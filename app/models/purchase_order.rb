# frozen_string_literal: true

class PurchaseOrder
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :supplier
  has_many :purchase_order_items, dependent: :destroy
  accepts_nested_attributes_for :purchase_order_items, reject_if: :all_blank, allow_destroy: true
  before_save :calculate_total_amount

  field :order_number, type: String
  field :order_date, type: Date
  field :total_amount, type: Float
  field :tax_amount, type: Float

  validates :order_number, presence: true, uniqueness: true

  private
    def calculate_total_amount
      self.total_amount = purchase_order_items.reject(&:marked_for_destruction?).map { |item| (item.quantity * item.unit_price) - (item.quantity * item.discount_amount) }.sum
    end
end
