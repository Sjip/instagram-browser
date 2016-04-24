formValidation = () ->
  $('#new_collection').on 'ajax:beforeSend', (xhr) ->
    start_date = moment($("#collection_start_date").val(), "YYYY-MM-DD").unix()
    end_date = moment($("#collection_end_date").val(), "YYYY-MM-DD").unix()
    hashtag = $("#collection_hashtag").val()
    error = false

    $('#new_collection .alert.alert-danger').html('')
    $('#new_collection .alert.alert-danger').addClass('hidden')
    $('#new_collection .form-group').removeClass('has-error')

    if end_date < start_date
      $('#collection_end_date').parents(".form-group").addClass('has-error')
      $('#collection_start_date').parents(".form-group").addClass('has-error')
      $('#new_collection .alert.alert-danger').removeClass('hidden').append($("<p></p>").append(I18n.t("start_date_greater_than_end_date")))
      error = true

    if isNaN(start_date) || $("#collection_start_date").val().length == 0
      $('#collection_start_date').parents(".form-group").addClass('has-error')
      $('#new_collection .alert.alert-danger').removeClass('hidden').append($("<p></p>").append(I18n.t("dates_are_required")))
      error = true

    if isNaN(end_date) || $("#collection_end_date").val().length == 0
      $('#collection_end_date').parents(".form-group").addClass('has-error')
      $('#new_collection .alert.alert-danger').removeClass('hidden').append($("<p></p>").append(I18n.t("dates_are_required")))
      error = true

    if hashtag.length == 0
      $('#collection_hashtag').parents(".form-group").addClass('has-error')
      $('#new_collection .alert.alert-danger').removeClass('hidden').append($("<p></p>").append(I18n.t("hashtag_missing")))
      error = true

    return !error
$ ->
  formValidation() 
