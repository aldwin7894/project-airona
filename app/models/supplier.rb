class Supplier
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :purchase_orders

  field :name, type: String
  field :contact_number, type: String
  field :address, type: String
end
