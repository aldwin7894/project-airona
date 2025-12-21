# frozen_string_literal: true

class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :brand
  has_many :purchase_order_items, dependent: :destroy
  has_many :sales_order_items, dependent: :destroy
  has_one :inventory, dependent: :destroy
  after_create :create_inventory

  field :name, type: String
  field :sku, type: String
  field :price, type: Float
  field :description, type: String
  field :color, type: String
  field :size, type: String
  field :type, type: String
  field :uom, type: String

  validates :name, presence: true, uniqueness: true

  def add_inventory(quantity)
    inventory.inc(quantity:)
  end

  def subtract_inventory(quantity)
    inventory.inc(quantity: -quantity)
  end

  private
    def create_inventory
      return if Inventory.exists?(product: self)

      Inventory.create(product: self, quantity: 0, selling_price: self.price)
    end
end
