class SalesOrder
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_many :sales_order_items

  field :order_number, type: String
  field :order_date, type: Date
  field :customer_name, type: String
  field :total_amount, type: Float
  field :discount, type: Float
  field :tax, type: Float
end
