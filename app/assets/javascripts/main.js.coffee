$(document).ready ->
  $('#card-number').mask('0000 0000 0000 0000')
  $('#mmyy').mask('00/00')
  $('#cvv').mask('0000')
  $(document).on 'change', (e) ->
    if (e.target.id == 'quantity')
      id = $(e.target).parents("tr").attr("order_item_id")
      $.ajax
        url: "order_items/#{id}"
        type: "PATCH"
        data:
          order_item:
            quantity: e.target.value
        success: (response) ->
          $( "tr[order_item_id='#{id}'] #total_price" ).text(response.total_price)
        error: (xhr, status, statusErr) ->
          console.log('not ok')

  $(document).on "click", (e) ->
    link  = $(e.target).parents("tr").attr('data-href')
    if link != undefined
      window.location = link
      console.log('ok')

