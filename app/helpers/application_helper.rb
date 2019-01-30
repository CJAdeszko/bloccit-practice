module ApplicationHelper

  def form_group_tag(errors, &block) #Accepts two arguments - an array of errors and a block - '&' turns the block into a proc
    css_class = 'form_group'
    css_class << ' has error' if errors.any?
    content_tag :div, capture(&block), class: css_class #content_tag helper method builds HTML and CSS to display the form element and any errors
  end

end
