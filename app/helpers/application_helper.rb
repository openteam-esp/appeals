module ApplicationHelper
  def show_attribute(object, field)
    return unless object
    content = ''
    content << content_tag(:span, object.class.human_attribute_name(field), :class => 'label')
    content << content_tag(:span,
                           (((l object.send(field)) if object.send(field).is_a?(Date)) ||
                           (t("show_attribute.yes") if object.send(field).is_a?(TrueClass)) ||
                           (t("show_attribute.no") if object.send(field).is_a?(FalseClass)) ||
                           (object.send("human_#{field}") if object.respond_to?("human_#{field}")) ||
                           (t('not_specified') if object.send(field).blank?) ||
                           object.send(field) ||
                           t('not_specified')),
                           :class => 'value')
    content_tag :div, raw(content), :class => "show_attribute #{field.to_s}"
  end

  def show_upload(upload)
    link_to "#{upload.file_name} (#{number_to_human_size(upload.file_size)})", upload_path(upload, upload.file_name)
  end

end
