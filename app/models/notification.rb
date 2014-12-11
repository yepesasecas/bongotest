require "base64"

class Notification < ActiveRecord::Base

  def self.build_with(params = {})

    order      = Base64.decode64(params["order"])
    order_id   = order.partition("idorder>")[2].partition("</idorder")[0]
    token_hash = order.partition("hash>")[2].partition("</hash")[0]

    create(order:       order,
           order_id:    order_id,
           status:      params["status"],
           partner_key: params["partner_key"],
           token:       params["token"],
           token_hash:  token_hash)
  end

  # def self.decode(order)
  #   Base64.decode64 order
  # end

  # def self.xml_id(order)
  #   decode = self.decode order
  #   order_id = decode.partition("idorder>")[2].partition("</idorder")[0]
  #   order_id
  # end

end
