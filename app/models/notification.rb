class Notification < ActiveRecord::Base
  def self.decode(xml)
    decode   = Base64.decode64 xml
    xml      = Nokogiri::XML decode
    order_id = xml.children.children.children[4].children.children[0].content
    order_id
  end
end
