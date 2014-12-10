require "base64"

class Notification < ActiveRecord::Base

  def self.decode(order)
    Base64.decode64 order
  end

  def self.xml_id(order)
    decode = self.decode order
    order_id = decode.partition("idorder>")[2].partition("</idorder")[0]
    order_id
  end

end
