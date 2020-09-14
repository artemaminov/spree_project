module Spree
  module OrderMailerDecorator

    def add_collection_email(calc, taxon_name, customer)
      subject = "#{Spree::Store.current.name} | #{Spree.t(:preorder)}"
      @category = taxon_name
      @variants = Spree::Variant.find(calc.keys)
      @amount = calc.values
      @customer = customer
      mail(to: customer[:phone], from: from_address, subject: subject) do |format|
        # format.html { render 'another_template' }
        format.html
      end
    end

  end
end

::Spree::OrderMailer.prepend Spree::OrderMailerDecorator if ::Spree::OrderMailer.included_modules.exclude? Spree::OrderMailerDecorator