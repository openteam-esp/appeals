module ApplicationHelper
  def show_attribute(object, field)
    content = ''
    content << content_tag(:span, object.class.human_attribute_name(field), :class => 'label')
    content << content_tag(:span, ((object.send("human_#{field}") if object.respond_to?("human_#{field}")) || object.send(field) || t('not_specified')), :class => 'value')
    content_tag :div, raw(content), :class => "show_attribute #{field.to_s}"
  end
end
