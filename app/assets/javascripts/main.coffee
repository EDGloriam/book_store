$(document).ready ->
  $(document).on 'change', (e) ->
    if (e.target.nodeName == 'INPUT')
      order_item_id = $(e.target).parents("tr").attr("order_item_id")
      console.log(order_item_id)
      $.ajax
        url: "order_items/#{order_item_id}"
        type: "PATCH"
        data: { order_item: { quantity: e.target.value, oi_id: order_item_id }}
        success: (response) ->
          $('#total_price').text(response.total_price)
        error: (xhr, status, statusErr) ->
          console.log('not ok')
