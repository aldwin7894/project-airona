class PurchaseOrdersController < ApplicationController
  before_action :set_purchase_order, only: [ :show, :edit, :update, :destroy ]

  respond_to :html

  def index
    @purchase_orders = PurchaseOrder.all
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

    def purchase_order_params
      params[:purchase_order]
    end
end
