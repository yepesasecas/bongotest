$(document).ready ->
  $("#search-oid").on "keyup", (e)->
    oid = $(this).val()
    
    if oid == ""
      $(".order-notification").show()
    else
      $(".order-notification").hide()
      $(".order-notification[data-oid='" + oid + "']").show()
