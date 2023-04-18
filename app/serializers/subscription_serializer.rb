class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes  :name,
              :price,
              :status,
              :frequency,
              :customer_id,
              :tea_id
end
