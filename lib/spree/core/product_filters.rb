module Spree
  module Core
    module ProductFilters
      COLORS_IMAGES = {
          "Красный": "content/products/color-1.png",
          "Светлый": "content/products/color-3.png",
          "Темный": "content/products/color-4.png"
      }

      #
      def self.option_with_values(option_scope, option, values)
        # get values IDs for Option with name {@option} and value-names in {@values} for use in SQL below
        option_values_ids = Spree::OptionValue.where(:presentation => [values].flatten).joins(option_type: :translations).where(OptionType.translations_table_name => {:name => option}).pluck("#{OptionValue.translations_table_name}.id")
        return option_scope if option_values_ids.empty?
        option_scope.where("#{Product.table_name}.id in (select product_id from #{Variant.table_name} v left join spree_option_value_variants ov on ov.variant_id = v.id where ov.option_value_id in (?))", option_values_ids)
      end

      # Add format scope
      Spree::Product.add_search_scope :format_any do |*opts|
        option_scope = Spree::Product.includes(:variants_including_master)
        option_type = ProductFilters.format_filter[:option]
        conds = opts.map { |opt| ProductFilters.option_with_values(option_scope, option_type, *opt) }
        scope = conds.shift
        conds.each do |new_scope|
          scope = scope.or(new_scope)
        end
        scope
      end

      # Format filter
      def self.format_filter
        option_type =Spree::OptionType.find_by(name: "format")
        formats = Spree::OptionValue.joins(variants: :product).where(:option_type_id => option_type).order(:position).map { |f| [f.presentation, "#{f.width}x#{f.height}x#{f.depth} мм"] }.compact.uniq
        {
            conds: nil,
            labels: formats,
            name: I18n.t('spree.filter.format'),
            option: 'format',
            popup: I18n.t('spree.filter,dimensions'),
            scope: :format_any,
            type: 'formats',
        }
      end

      # Add selective format scope
      Spree::Product.add_search_scope :selective_format_any do |*opts|
        Spree::Product.format_any(*opts)
      end

      # Selective format filter
      def self.selective_format_filter(taxon = nil)
        option_type =Spree::OptionType.find_by(name: "format")
        formats = Spree::OptionValue.joins(variants: {product: :taxons}).where(:option_type_id => option_type).where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants).order(:position).map { |f| [f.presentation, "#{f.width}x#{f.height}x#{f.depth} мм"] }.compact.uniq
        {
            conds: nil,
            labels: formats,
            name: I18n.t('spree.filter.selective_format'),
            option: 'format',
            popup: I18n.t('spree.filter,dimensions'),
            scope: :selective_format_any,
            type: 'formats',
        }
      end

      # Add color scope
      Spree::Product.add_search_scope :color_any do |*opts|
        conds = opts.map { |o| ProductFilters.color_filter[:conds][o] }.reject(&:nil?)
        scope = conds.shift
        conds.each do |new_scope|
          scope = scope.or(new_scope)
        end
        Spree::Product.joins(product_properties: :translations, properties: :translations).where("#{Spree::Property.translations_table_name}.name" => 'color-tone').where(scope)
      end

      # Color filter
      def self.color_filter
        color_property = Spree::Property.find_by(name: 'color-tone')
        formats = color_property ? Spree::ProductProperty.where(property_id: color_property.id).pluck(:value).uniq.map(&:to_s) : []
        pp = Arel::Table.new(Spree::ProductProperty.translations_table_name)
        conds = Hash[*formats.map { |b| [b, pp[:value].eq(b)] }.flatten]
        {
            conds: conds,
            images: COLORS_IMAGES,
            labels: formats.sort.map { |k| [k, k] },
            name: I18n.t('spree.filter.color'),
            popup: I18n.t('spree.filter.color'),
            scope: :color_any,
            type: 'colors',
        }
      end

      # Add selective color scope
      Spree::Product.add_search_scope :selective_color_any do |*opts|
        Spree::Product.color_any(*opts)
      end

      # Selective color filter
      def self.selective_color_filter(taxon = nil)
        color_property = Spree::Property.find_by(name: 'color-tone')
        scope = Spree::ProductProperty.where(property: color_property)
        formats = scope.pluck(:value).uniq
        {
          images: COLORS_IMAGES,
          labels: formats.sort.map { |k| [k, k] },
          name: I18n.t('spree.filter.selective_color'),
          popup: I18n.t('spree.filter.color'),
          scope: :selective_color_any,
          type: 'colors',
        }
      end

      def self.taxon_selective(taxon)
        taxon ||= Spree::Taxonomy.first.root
        joins(product: :taxons).where("#{Spree::Taxon.table_name}.id" => [taxon] + taxon.descendants)
      end

    end
  end
end
