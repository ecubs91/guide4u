# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  payment.setupForm()

payment =
  setupForm: ->
    $('#edit_tutorship').submit ->
        $('input[type=submit]').attr('disabled', true)
        Stripe.card.createToken($('#edit_tutorship'), payment.handleStripeResponse)
        false
        
 handleStripeResponse: (status, response) ->
    if status == 200
      $('#edit_tutorship').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#edit_tutorship')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)