# frozen_string_literal: true
# typed: true

class InventoriesController < ApplicationController
  before_action :set_inventory, only: [ :show, :edit, :update, :destroy ]
  before_action :set_lookups, only: [ :new, :edit ]

  respond_to :html

  def index
    @inventories = Inventory.includes(product: :brand).all
    respond_with(@inventories)
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
