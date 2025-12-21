# frozen_string_literal: true

class SalesOrderItem
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :sales_order
  belongs_to :product
  after_validation :calculate_total_amount
  after_create :update_inventory

  field :quantity, type: Integer
  field :unit_price, type: Float
  field :total_amount, type: Float
  field :discount_amount, type: Float
  field :tax_amount, type: Float

  private
    def calculate_total_amount
      self.total_amount = (quantity * unit_price) - (quantity * discount_amount)
    end

    def update_inventory
      product.subtract_inventory(self.quantity)
    end
end
