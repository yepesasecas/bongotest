class Notification < ActiveRecord::Base
  def self.decode(order)
    require "base64"
    decode   = Base64.decode64 order
    order_id = decode.partition("idorder>")[2].partition("</idorder")[0]
    order_id
  end
end
