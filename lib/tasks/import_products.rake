require 'csv'

VARIANTS_FIELD = :'product-variants'
VARIANT_REGEX = /(?<=\[)\d+(?=\])/.freeze
UNNEEDED_VARIANT_KEYS = %i[product_id product_name].freeze
OPTION_TYPE_KEY = :format
OPTION_TYPE_PRESENTATION = 'Формат'

def log(row, rows)
  print "Importing brick #{row} of #{rows.count - 1}..."
end

def log_ok
  puts " Ok."
end

def import_error(product_information, product)
  puts '--------------------------------'
  puts 'A product could not be imported!'
  puts 'product_information:'
  pp product_information
  puts 'Product attributes:'
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
  return if product.nil? || taxon_hierarchy.nil?

  taxon_hierarchy.split(/\s*\|\s*/).each do |hierarchy|
    hierarchy = hierarchy.split(/\s*>\s*/)
    taxonomy = Spree::Taxonomy.where(name: hierarchy.first).first
    taxonomy = Spree::Taxonomy.create(name: hierarchy.first.capitalize) if taxonomy.nil?
    last_taxon = taxonomy.root
    hierarchy.shift
    hierarchy.each do |taxon|
      last_taxon = last_taxon.children.find_or_create_by(name: taxon, taxonomy_id: taxonomy.id)
    end
    product.taxons << last_taxon unless product.taxons.include?(last_taxon)
  end
end

namespace :db do
  task import_bricks: :environment do
    ARGV.each { |a| task a.to_sym do ; end }
    filename = ARGV[1]
    variants_filename = ARGV[2]
    separator_char = ','
    quote_char = '"'

    rows = CSV.parse(open(filename).read, col_sep: separator_char, quote_char: quote_char)
    variants_rows = CSV.parse(open(variants_filename).read, col_sep: separator_char, quote_char: quote_char)
    col = get_column_mappings(rows[0])
    variants_col = get_column_mappings(variants_rows[0])
    variants_ids = variants_rows.map { |row| row[variants_col[:product_id]] }

    puts "Importing #{rows.count - 1} products and #{variants_rows.count - 1} variants..."

    ActiveRecord::Base.transaction do
      rows[1..-1].each_with_index do |row, i|
        log(i + 1, rows)

        product = Spree::Product.new
        product_information = {}
        properties_hash = {}

        col.each do |key, value|
          row[value].try :strip!
          row[value] = '' if (key == :sku) && row[value].nil?
          product_information[key] = row[value]
        end

        if product_information[:available_on].nil?
          product_information[:available_on] = Date.today - 1.day
        end
        if product_information[:retail_only].nil?
          product_information[:retail_only] = 0
        end
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

        if product.valid? && product.save
          properties_hash.each do |property, value|
            product_property = Spree::ProductProperty.where(product_id: product.id, property_id: property.id, value: value).first_or_initialize
            product_property.save!
          end
          associate_product_with_taxon(product, product_information[:taxonomy])
          unless product_information[VARIANTS_FIELD].empty?
            variants = product_information[VARIANTS_FIELD].scan(VARIANT_REGEX)
            variants.each do |variant|
              variant_information = {}
              variant_index = variants_ids.find_index(variant)
              next if variant_index.nil?

              variant_index += 1
              variants_col.each do |key, value|
                puts "--- #{variant_index} - #{value} - #{variants_rows[variant_index][value]}"
                variants_rows[variant_index][value].try :strip!
                if key == OPTION_TYPE_KEY
                  option_type_attributes = { name: key.to_s, presentation: OPTION_TYPE_PRESENTATION }
                  option_type = Spree::OptionType.find_or_create_by(option_type_attributes)
                  option_value = Spree::OptionValue.find_or_create_by(name: variants_rows[variant_index][value], presentation: variants_rows[variant_index][value])
                  unless product.option_types.exists?(option_type.id)
                    product.option_types << option_type
                  end
                  unless option_type.option_values.exists?(option_value.id)
                    option_type.option_values << option_value
                  end
                  variant_information[:option_values] = [option_value]
                  next
                end
                unless UNNEEDED_VARIANT_KEYS.include?(key)
                  variants_rows[variant_index][value] = variants_rows[variant_index][value].to_f if key == :price
                  variant_information[key] = variants_rows[variant_index][value]
                end
              end

              product.variants.create(variant_information)
            end
          end
        else
          import_error(product_information, product)
          exit(1)
        end

        log_ok
      end
    end
  end
end

