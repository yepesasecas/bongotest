require "base64"

class Notification < ActiveRecord::Base

  def self.build_with(params = {}, request)
    partner_key = params[:partner_key] || "-"
    token       = params[:token] || "-"
    ip          = request[:request].remote_ip || "-"

    if params[:productID]
      order      = params.map{|k,v| "#{k}=#{v}"}.join('&')
      order_id   = params[:productID]
      token_hash = "-"
      if params[:sellable]
        status = "sellable #{params[:sellable]}"
      elsif params[:exportable]
        status = "exportable #{params[:exportable]}"
      elsif params[:classified]
        status = "classified #{params[:classified]}"
      else
        status = "-"
      end

    elsif params["merchant_order_number"]
      order      = params.map{|k,v| "#{k}=#{v}"}.join('&')
      order_id = params[:merchant_order_number]
      token_hash = "-"
      status     = params[:status]

    else
      order      = params.map{|k,v| "#{k}=#{v}"}.join('&')
      order_dec  = Base64.decode64(params[:order])
      order_id   = order_dec.partition("idorder>")[2].partition("</idorder")[0] || "-"
      token_hash = order_dec.partition("hash>")[2].partition("</hash")[0] || "-"
      status     = params[:status]
    end

    new(order:       order,
        order_id:    order_id,
        status:      status,
        partner_key: partner_key,
        token:       token,
        token_hash:  token_hash,
        ip:          ip)
  end
end
