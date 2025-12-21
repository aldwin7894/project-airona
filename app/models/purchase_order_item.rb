class PurchaseOrderItem
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :purchase_order
  belongs_to :product

  field :quantity, type: Integer
  field :unit_price, type: Float
  field :total_amount, type: Float
  field :discount, type: Float
  field :tax, type: Float
end
