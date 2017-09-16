$(document).ready ->
  $(document).on 'change', (e) ->
    if (e.target.nodeName == 'INPUT')
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
