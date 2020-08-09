require 'csv'

def log(row, rows)
  puts "Importing brick #{row} of #{rows.count - 1}..."
end

def log_ok
  puts "\rOk"
end

def import_error(product_information, product)
  puts "--------------------------------"
  puts "A product could not be imported!"
  puts "product_information:"
  pp product_information
  puts "Product attributes:"
  pp product.inspect
  puts "Error: #{product.errors.full_messages.join(', ')}"
end

def get_column_mappings(row)
  mappings = {}
  row.each_with_index do |heading, index|
    if heading.blank?
      break
    else
      mappings[heading.downcase.gsub(/\A\s*/, '').chomp.gsub(/\s/, '_').to_sym] = index
    end
  end
  mappings
end

def associate_product_with_taxon(product, taxon_hierarchy)
  byebug
  return if product.nil? || taxon_hierarchy.nil?

  taxon_hierarchy.split(/\s*\|\s*/).each do |hierarchy|
    hierarchy = hierarchy.split(/\s*>\s*/)
    taxonomy = Spree::Taxonomy.where(name: hierarchy.first).first
    taxonomy = Spree::Taxonomy.create(:name => hierarchy.first.capitalize) if taxonomy.nil?
    last_taxon = taxonomy.root
    hierarchy.shift
    hierarchy.each do |taxon|
      last_taxon = last_taxon.children.find_or_create_by(name: taxon, taxonomy_id: taxonomy.id)
    end
    product.taxons << last_taxon unless product.taxons.include?(last_taxon)
  end
end

namespace :db do
  task :import_bricks => :environment do
    ARGV.each { |a| task a.to_sym do ; end }
    filename = ARGV[1]
    separator_char = ','
    quote_char = '"'

    rows = CSV.parse(open(filename).read, :col_sep => separator_char, :quote_char => quote_char)
    col = get_column_mappings(rows[0])

    puts "Importing #{rows.count} bricks..."

    ActiveRecord::Base.transaction do
      rows[1..-1].each_with_index do |row, i|
        log(i + 1, rows)

        product = Spree::Product.new
        product_information = {}
        properties_hash = {}

        col.each do |key, value|
          row[value].try :strip!
          row[value] = "" if (key === :sku) and (row[value] === nil)
          product_information[key] = row[value]
        end

        product_information[:available_on] = Date.today - 1.day if product_information[:available_on].nil?
        product_information[:retail_only] = 0 if product_information[:retail_only].nil?
        if product_information[:shipping_category_id].nil?
          sc = Spree::ShippingCategory.first
          product_information[:shipping_category_id] = sc.id unless sc.nil?
        end

        product_information.each do |field, value|
          property = Spree::Property.where(name: field).first
          if product.respond_to?("#{field}=")
            product.send("#{field}=", value)
          elsif property and value.present?
            properties_hash[property] = value
          end
        end

        if product.valid? and product.save
          properties_hash.each do |property, value|
            product_property = Spree::ProductProperty.where(:product_id => product.id, :property_id => property.id, value: value).first_or_initialize
            product_property.save!
          end
          associate_product_with_taxon(product, product_information[:taxonomy])
        else
          import_error(product_information, product)
        end

        log_ok
      end
    end
  end
end
