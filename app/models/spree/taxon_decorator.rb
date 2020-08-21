module Spree
  module TaxonDecorator
    def applicable_filters
      fs = []
      fs << Spree::Core::ProductFilters.color_filter if Spree::Core::ProductFilters.respond_to?(:color_filter)
      fs << Spree::Core::ProductFilters.selective_format_filter(self) if Spree::Core::ProductFilters.respond_to?(:selective_format_filter)
      fs
    end
  end
end

::Spree::Taxon.prepend Spree::TaxonDecorator if ::Spree::Taxon.included_modules.exclude?(Spree::TaxonDecorator)