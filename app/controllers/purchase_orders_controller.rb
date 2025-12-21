# frozen_string_literal: true
# typed: true

class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [ :show, :edit, :update, :destroy ]
  before_action :set_lookups, only: [ :new, :edit, :create, :update ]

  respond_to :html

  def index
    @purchase_orders = PurchaseOrder.includes(:supplier).all
    respond_with(@purchase_orders)
  end

  def show
    respond_with(@purchase_order)
  end

  def new
    @purchase_order = PurchaseOrder.new
    respond_with(@purchase_order)
  end

  def edit
    # edit
  end

  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    @purchase_order.save
    respond_with(@purchase_order)
  end

  def update
    @purchase_order.update(purchase_order_params)
    respond_with(@purchase_order)
  end

  def destroy
    @purchase_order.destroy!
    respond_with(@purchase_order)
  end

  private
    def set_purchase_order
      @purchase_order = PurchaseOrder.find(params[:id])
    end

    def set_lookups
      @suppliers = Supplier.all.map { |supplier| [ supplier.name, supplier.id ] }
      @products = Product.all.map { |product| [ product.name, product.id ] }
    end

    def purchase_order_params
      params.expect(
        purchase_order: [
          :supplier_id,
          :order_number,
          :order_date,
          :total_amount,
          :discount_amount,
          :tax_amount,
          purchase_order_items_attributes: [
            :product_id,
            :quantity,
            :unit_price,
            :discount_amount,
            :tax_amount,
            :_destroy
          ]
        ]
      )
    end
end
