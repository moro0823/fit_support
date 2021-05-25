class Public::NotificationsController < ApplicationController
  def update
    notification = Notification.find(params[:id])
    if notification.update(checked: true) 
      redirect_back(fallback_location: root_path)
    end
  end
end
