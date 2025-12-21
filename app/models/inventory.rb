# frozen_string_literal: true

class Inventory
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :product

  field :quantity, type: Integer
  field :selling_price, type: Float

  validates_presence_of :product
  validates :quantity, comparison: { greater_than: 0 }
end
