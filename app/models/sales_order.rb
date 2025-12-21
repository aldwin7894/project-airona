# frozen_string_literal: true

class SalesOrder
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :sales_order_items, dependent: :destroy
  accepts_nested_attributes_for :sales_order_items, reject_if: :all_blank, allow_destroy: true
  before_save :calculate_total_amount

  field :order_number, type: String
  field :order_date, type: Date
  field :customer_name, type: String
  field :total_amount, type: Float
  field :discount_amount, type: Float
  field :tax_amount, type: Float

  validates :order_number, presence: true, uniqueness: true

  private
    def calculate_total_amount
      self.total_amount = sales_order_items.reject(&:marked_for_destruction?).map { |item| (item.quantity * item.unit_price) - (item.quantity * item.discount_amount) }.sum
    end
end
