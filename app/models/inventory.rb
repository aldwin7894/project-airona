class Inventory
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :product

  field :quantity, type: Integer
  field :selling_price, type: Float
end
