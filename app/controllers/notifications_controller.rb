class NotificationsController < ApplicationController

  def index
    @notifications = Notification.all.order("created_at DESC").limit(200)
  end

  def callback
    notification = Notification.build_with params, request: request

    if notification.save!
      render text: "SUCCESS"
    else
      render text: "not able to save notification",  status: :internal_server_error
    end
  end

  private

    def notification_params
      params.require(:notification).permit(:status, :order, :partner_key, :token)
    end
end
