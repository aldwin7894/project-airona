class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :purchase_order_item
  embedded_in :sales_order_item
  embedded_in :inventory

  field :name, type: String
  field :price, type: Float
  field :description, type: String
  field :color, type: String
  field :size, type: String
  field :type, type: String
end
