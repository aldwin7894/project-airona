class Inventory
  include Mongoid::Document
  include Mongoid::Timestamps

  embeds_one :product, class_name: "Product", inverse_of: :inventory

  field :quantity, type: Integer
  field :selling_price, type: Float
end
