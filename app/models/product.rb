class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :purchase_order_item
  has_many :sales_order_item
  has_one :inventory

  field :name, type: String
  field :price, type: Float
  field :description, type: String
  field :color, type: String
  field :size, type: String
  field :type, type: String
end
