# frozen_string_literal: true

class Brand
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :products

  field :name, type: String

  validates :name, presence: true, uniqueness: true
end
