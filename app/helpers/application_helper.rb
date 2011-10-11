module ApplicationHelper
  def show_attribute(object, field)
    content = ''
    content << content_tag(:span, object.class.human_attribute_name(field), :class => 'label')
    content << content_tag(:span, (((l object.send(field)) if object.send(field).is_a?(Date)) || (object.send("human_#{field}") if object.respond_to?("human_#{field}")) || (t('not_specified') if object.send(field).blank?) || object.send(field) || t('not_specified')), :class => 'value')
    content_tag :div, raw(content), :class => "show_attribute #{field.to_s}"
  end
end
