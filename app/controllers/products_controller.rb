# frozen_string_literal: true
# typed: true


class ProductsController < ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]
  before_action :set_lookups, only: [ :new, :edit, :create, :update ]

  respond_to :html

  def index
    @products = Product.includes(:brand).all
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
    # edit
  end

  def create
    @product = Product.new(product_params)
    @product.save
    respond_with(@product)
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    @product.destroy!
    respond_with(@product)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def set_lookups
      @brands = Brand.all.map { |brand| [ brand.name, brand.id ] }
    end

    def product_params
      params.expect(
        product: [
          :brand_id,
          :name,
          :price,
          :description,
          :color,
          :size,
          :type
        ]
      )
    end
end
