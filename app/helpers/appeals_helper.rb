module AppealsHelper

  def appeal_author(appeal)
    result = ''
    result << appeal.surname
    result << ' ' + appeal.name
    result << ' ' + appeal.patronymic unless appeal.patronymic.blank?
    result
  end

end
