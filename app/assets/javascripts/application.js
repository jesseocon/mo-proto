// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .


$(function() {
  $("#credit-card input, #credit-card select").attr("disabled", false);
  $("form:has(#credit-card)").submit(function() {
    var form = this;
    $("#user_submit").attr("disabled", true);
    $("#credit-card input, #credit-card select").attr("name", "");
    $("#credit-card-errors").hide();

    if (!$("#credit-card").is(":visible")) {
      $("#credit-card input, #credit-card select").attr("disabled", true);
      return true;
    }
    
    var card = {
      number:   $("#credit_card_number").val(),
      expMonth: $("#_expiry_date_2i").val(),
      expYear:  $("#_expiry_date_1i").val(),
      cvc:      $("#cvv").val()
    };


    Stripe.createToken(card, function(status, response) {
      if (status === 200) {
        alert(status)
        $("#last_4_digits").val(response.card.last4);
        $("#stripe_token").val(response.id);
        alert($('#stripe_token').val());
        form.submit();
      } else {
        $("#stripe-error-message").text(response.error.message);
        $("#credit-card-errors").show();
        $("#user_submit").attr("disabled", false);
      }
    });

    return false;
  });

  $("#change-card a").click(function() {
    $("#change-card").hide();
    $("#credit-card").show();
    $("#credit_card_number").focus();
    return false;
  });
});
