json.array!(@notifications) do |notification|
  json.extract! notification, :id, :status, :order_id
  json.url notification_url(notification, format: :json)
end
