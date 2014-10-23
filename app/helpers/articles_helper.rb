module ArticlesHelper
  def admin_button(article)
    if article.published?
      link_text = 'Unpublish'
      button_style = 'btn-success'
    else
      link_text = 'Publish'
      button_style = 'btn-danger'
    end
    render partial: 'articles/admin_button', locals: {
      article: article,
      link_text: link_text,
      button_style: button_style
    }
  end
end
