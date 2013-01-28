class <%= class_name %>Observer < ActiveRecord::Observer
  def after_create(<%= file_name %>)
    <%= class_name %>Notifier.signup_notification(<%= file_name %>).deliver
  end

  def after_save(<%= file_name %>)
    <%= class_name %>Notifier.activation(<%= file_name %>).deliver if <%= file_name %>.recently_activated?
  end
end