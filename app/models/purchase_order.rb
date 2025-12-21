class PurchaseOrder
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :supplier
  embeds_many :purchase_order_items

  field :order_number, type: String
  field :order_date, type: Date
end
