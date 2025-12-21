# frozen_string_literal: true

class PurchaseOrderItem
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :purchase_order
  belongs_to :product
  after_validation :calculate_total_amount
  after_create :update_inventory

  field :quantity, type: Integer
  field :unit_price, type: Float
  field :total_amount, type: Float
  field :discount_amount, type: Float
  field :tax_amount, type: Float

  validates_presence_of :product, :purchase_order
  validates :quantity, presence: true, comparison: { greater_than: 0 }

  private
    def calculate_total_amount
      self.total_amount = (self.quantity * self.unit_price) - (self.quantity * self.discount_amount)
    end

    def update_inventory
      product.add_inventory(self.quantity)
    end
end
