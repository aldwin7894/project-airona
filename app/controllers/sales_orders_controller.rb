class SalesOrdersController < ApplicationController
  before_action :set_sales_order, only: [ :show, :edit, :update, :destroy ]

  respond_to :html

  def index
    @sales_orders = SalesOrder.all
    respond_with(@sales_orders)
  end

  def show
    respond_with(@sales_order)
  end

  def new
    @sales_order = SalesOrder.new
    respond_with(@sales_order)
  end

  def edit
  end

  def create
    @sales_order = SalesOrder.new(sales_order_params)
    @sales_order.save
    respond_with(@sales_order)
  end

  def update
    @sales_order.update(sales_order_params)
    respond_with(@sales_order)
  end

  def destroy
    @sales_order.destroy!
    respond_with(@sales_order)
  end

  private
    def set_sales_order
      @sales_order = SalesOrder.find(params[:id])
    end

    def sales_order_params
      params[:sales_order]
    end
end
