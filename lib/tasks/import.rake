# frozen_string_literal: true
# typed: true

require "csv"

namespace :import do
  desc "Import initial data from CSV files"
  task :data, [:filename] => :environment do |task, args|
    filename = args[:filename] || "data.csv"
    if filename.blank?
      puts "Usage: rake import:csv[filename.csv]"
      exit
    end

    file_path = Rails.root.join("lib", "data", filename)
    if !File.exist?(file_path)
      puts "Error: File not found at #{file_path}"
      exit
    end

    count = 0
    CSV.foreach(file_path, headers: true) do |row|
      brand_name = row["BRAND"].to_s.strip
      name = row["NAME"].to_s.strip
      description = row["DESCRIPTION"].to_s.strip
      color = row["COLOR"].to_s.strip
      size = row["SIZE"].to_s.strip
      type = row["TYPE"].to_s.strip
      sku = row["SKU"].to_s.strip
      uom = row["UOM"].to_s.strip
      price = row["UNIT PRICE"].to_s.strip.to_f
      quantity = row["QTY"].to_s.strip.to_i

      brand = brand_name.present? ? Brand.find_or_create_by!(name: brand_name) : Brand.find_or_create_by!(name: "GENERIC")

      product = Product.find_or_initialize_by(name:)
      product.brand = brand
      product.description = description
      product.color = color
      product.size = size
      product.type = type
      product.sku = sku
      product.uom = uom
      product.price = price
      product.save!

      inventory = product.inventory || product.build_inventory
      inventory.quantity = quantity
      inventory.selling_price = price
      inventory.inventory_type = "hardware"
      inventory.save!

      puts "Imported product: #{product.name} (#{product.sku})"
      count += 1
    end

    puts "Data import completed! Total products imported: #{count}"
  end
end
