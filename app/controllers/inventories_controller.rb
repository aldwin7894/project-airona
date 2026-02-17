# frozen_string_literal: true
# typed: true

class InventoriesController < ApplicationController
  before_action :set_inventory, only: [ :show, :edit, :update, :destroy ]
  before_action :set_lookups, only: [ :new, :edit ]

  respond_to :html, :json

  def index
    respond_to do |format|
      format.html
      format.json do
        @inventories = Inventory.collection.aggregate([
          {
            "$lookup": {
              "from": "products",
              "localField": "product_id",
              "foreignField": "_id",
              "as": "product"
            }
          },
          {
            "$unwind": "$product",
          },

          {
            "$lookup": {
              "from": "brands",
              "localField": "product.brand_id",
              "foreignField": "_id",
              "as": "brand"
            }
          },
          {
            "$unwind": "$brand"
          },
          {
            "$sort": {
              "product.name": 1,
              "brand.name": 1,
              "name": 1
            }
          },
          {
            "$addFields": {
              "product_name": "$product.name",
              "brand_name": "$brand.name"
            }
          },
          {
            "$replaceRoot": {
              "newRoot": "$$ROOT"
            }
          }
        ]).map do |doc|
          doc["inventory_type"] = doc["inventory_type"].titleize
          Inventory.instantiate(doc)
        end
        respond_with(@inventories)
      end
    end
  end

  def show
    respond_with(@inventory)
  end

  def new
    @inventory = Inventory.new
    respond_with(@inventory)
  end

  def edit
    # edit
  end

  def create
    @inventory = Inventory.new(inventory_params)
    @inventory.save
    respond_with(@inventory)
  end

  def update
    @inventory.update(inventory_params)
    respond_with(@inventory)
  end

  def destroy
    @inventory.destroy!
    respond_with(@inventory)
  end

  private
    def set_inventory
      @inventory = Inventory.find(params[:id])
    end

    def set_lookups
      @products = Product.all.map { |product| [ product.name, product.id ] }
      @inventory_types = [["Hardware", "hardware"], ["Motor Parts", "motor_parts"]]
    end

    def inventory_params
      params.expect(
        inventory: [
          :brand_id,
          :product_id,
          :quantity,
          :selling_price
        ]
      )
    end
end
