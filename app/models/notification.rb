require "base64"

class Notification < ActiveRecord::Base

  def self.build_with(params = {}, request)
    order      = Base64.decode64(params[:order])
    # order_id   = order.partition("idorder>")[2].partition("</idorder")[0] || "n/a"
    order_id = "n/a"
    # token_hash = order.partition("hash>")[2].partition("</hash")[0] || "n/a"
    token_hash = "n/a"

    new(order:       order,
        order_id:    order_id,
        status:      params[:status],
        partner_key: params[:partner_key],
        token:       params[:token],
        token_hash:  token_hash,
        ip:          request[:request].remote_ip)
  end
end
