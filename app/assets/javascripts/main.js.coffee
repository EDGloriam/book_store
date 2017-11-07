$(document).on "turbolinks:load", ->

  #=============================== Read More link =====================================
  showChar = 150
  ellipsis = " ..."
  moretext = "Read More"
  lesstext = "Close"

  $('.description').each ->
    content = $(this).html()
    if (content.length > showChar)
      truncated = content.substr(0, showChar);
      left = content.substr(showChar, content.length - showChar);
      html = truncated + '<span class="ellipsis">' + ellipsis + '</span><span class="morecontent"><span>' + left + '</span><a href="" class="morelink in-gold-500 ml-10">' + moretext + '</a></span>'
      $(this).html(html)

  $(".morelink").on "click", (e) ->
    if($(this).hasClass("less"))
      $(this).removeClass("less")
      $(this).html(moretext)
    else
      $(this).addClass("less")
      $(this).html(lesstext)
    $(this).parent().prev().toggle()
    $(this).prev().toggle()
    return false

  #=============================== Mask =====================================
  $('#card-number').mask('0000 0000 0000 0000')
  $('#mmyy').mask('00/00')
  $('#cvv').mask('0000')

  #=============================== Update price of a single order item =====================================
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
          console.log(response)
          $( "tr[order_item_id='#{id}'] #total_price" ).text(response.total_price)
        error: (xhr, status, statusErr) ->
          console.log('failed')

  #=============================== link to single order =====================================
  $(document).on "click", (e) ->
    link = $(e.target).parents("tr").attr('data-href')
    if link != undefined
      window.location = link

  #=============================== [-] quantity [+] =====================================
  $('#dec_value').on 'click', (e)->
    e.preventDefault()
    book_quantity = parseInt( $(this).next()[0].value, 10 )
    $(this).next()[0].value = if book_quantity <= 1 then 1 else book_quantity - 1

  $('#inc_value').on 'click', (e)->
    e.preventDefault()
    $(this).prev()[0].value = 1 + parseInt( $(this).prev()[0].value, 10 )

