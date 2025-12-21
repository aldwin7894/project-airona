# frozen_string_literal: true

class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :brand
  has_many :purchase_order_items
  has_many :sales_order_items
  has_one :inventory
  after_create :create_inventory

  field :name, type: String
  field :price, type: Float
  field :description, type: String
  field :color, type: String
  field :size, type: String
  field :type, type: String

  validates_presence_of :brand
  validates :name, presence: true, uniqueness: true

  def add_inventory(quantity)
    inventory.inc(quantity:)
  end

  def subtract_inventory(quantity)
    inventory.inc(quantity: -quantity)
  end

  private
    def create_inventory
      return if Inventory.where(product: self).exists?

      Inventory.create(product: self, quantity: 0, selling_price: self.price)
    end
end
