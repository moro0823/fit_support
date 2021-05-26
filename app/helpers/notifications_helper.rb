module NotificationsHelper
  def unchecked_notifications
    @notifications = current_customer.passive_notifications.where(checked: false)
  end
end
