module ApplicationHelper
  def list_comments comments
    content_tag(:div) do
      comments.map do |comment|  
        content_tag(:div, class: "list-group-item") do
          content =  content_tag(:small, "#{comment.user.name} em #{l(comment.created_at, format: :comment)}")
          content += content_tag(:p, comment.body, class: "list-group-item-text")
          content += content_tag(:a, "responder", class: "btn btn-primary btn-xs comment", id: comment.id)
          content += list_answers(comment.childrens) if comment.childrens.any?
          content
        end
      end.join("").html_safe
    end
  end

  def list_answers comments
    content_tag(:div) do
      comments.map do |comment|  
        content_tag(:div, class: "list-group-item", id: comment.id) do
          content =  content_tag(:small, "#{comment.user.name} respondeu em #{l(comment.created_at, format: :comment)}")
          content += content_tag(:p, comment.body, class: "list-group-item-text")
          content += content_tag(:a, "responder", class: "btn btn-primary btn-xs comment", id: comment.id)
          content += list_comments(comment.childrens) if comment.childrens.any?
          content
        end
      end.join("").html_safe
    end
  end
end
