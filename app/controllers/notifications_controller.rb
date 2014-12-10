class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  def index
    @notifications = Notification.all.order("created_at DESC")
  end

  def show
  end

  def new
    @notification = Notification.new
  end

  def edit
  end

  def create
    @notification = Notification.new(notification_params)
    respond_to do |format|
      if @notification.save
        format.html do
          redirect_to @notification, notice: 'Notification was successfully created.' 
        end
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json do
          render json: @notification.errors, status: :unprocessable_entity 
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html do 
          redirect_to @notification, notice: 'Notification was successfully updated.' 
        end
        format.json do
          render :show, status: :ok, location: @notification 
        end
      else
        format.html { render :edit }
        format.json do 
          render json: @notification.errors, status: :unprocessable_entity 
        end
      end
    end
  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html do
        redirect_to notifications_url,notice: 'Notification was successfully destroyed.' 
      end
      format.json { head :no_content }
    end
  end

  def callback
    p params
    @notification = Notification.create(status: params["status"], 
                                        partner_key: params["partner_key"],
                                        order: Notification.xml_id(params["order"]), 
                                        ip: get_request_ip, 
                                        token: params["token"],
                                        blob: Notification.decode(params["order"]))
    render text: "SUCCESS"
  end

  private
    def set_notification
      @notification = Notification.find(params[:id])
    end

    def notification_params
      params.require(:notification).permit(:status, :order_id)
    end

    def get_request_ip
      request.remote_ip || "Not Identified"
    end

end
