require "base64"

class Notification < ActiveRecord::Base

  def self.build_with(params = {}, request)
    partner_key = params[:partner_key]
    token       = params[:token]
    ip          = request[:request].remote_ip

    if params[:productID]
      order      = params[:order]
      order_id   = params[:productID]
      token_hash = "n/a"
      status     = "Product"
    else
      order      = Base64.decode64(params[:order])
      order_id   = order.partition("idorder>")[2].partition("</idorder")[0] || "n/a"
      token_hash = order.partition("hash>")[2].partition("</hash")[0] || "n/a"
      status     = params[:status]
    end

    puts params

    new(order:       order,
        order_id:    order_id,
        status:      status,
        partner_key: partner_key,
        token:       token,
        token_hash:  token_hash,
        ip:          ip)
  end
end
