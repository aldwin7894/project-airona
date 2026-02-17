# frozen_string_literal: true
# typed: true

class SuppliersController < ApplicationController
  layout :custom_layout
  before_action :set_supplier, only: [ :show, :edit, :update, :destroy ]

  respond_to :html, :json

  def index
    respond_to do |format|
      format.html
      format.json do
        @suppliers = Supplier.collection.aggregate([
          {
            "$sort": {
              "name": 1
            }
          },
        ]).map do |doc|
          Supplier.instantiate(doc)
        end
        respond_with(@suppliers)
      end
    end
  end

  def show
    respond_with(@supplier)
  end

  def new
    @supplier = Supplier.new
    respond_with(@supplier)
  end

  def edit
    # edit
  end

  def create
    @supplier = Supplier.new(supplier_params)
    @supplier.save
    respond_with(@supplier)
  end

  def update
    @supplier.update(supplier_params)
    respond_with(@supplier)
  end

  def destroy
    @supplier.destroy!
    respond_with(@supplier)
  end

  private
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    def supplier_params
      params.expect(
        supplier: [
          :name,
          :contact_number,
          :address
        ]
      )
    end
end
