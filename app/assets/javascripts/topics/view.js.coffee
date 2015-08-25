class ViewTopic
  run: () ->
    show_new_comment()

  show_new_comment = () ->
    $(".comment").on 'click', (e) ->
      self = $(this)
      if self.attr('disabled') != 'disabled'
        template = $("#template").clone()
        template.find(".comment_parent").val(self.attr("id"))
        self.parent().prepend(template)
        template.find(".cancel").on 'click', (e) -> close_new_comment(self, template)
        template.show()
        self.attr("disabled", true)

  close_new_comment = (button, template) ->
    $(button).removeAttr("disabled")
    $(template).remove()

$ () -> new ViewTopic().run()