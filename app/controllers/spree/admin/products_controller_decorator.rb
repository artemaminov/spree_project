module Spree
    module Admin
        module ProductsControllerDecorator

            def update_positions
                ApplicationRecord.transaction do
                    per_page = params[:per_page] || 25
                    page = params[:page] || 1

                    params[:positions].each do |id, index|
                        Spree::Product.where(id: id).update_all(position: index.to_i + per_page.to_i * (page.to_i - 1))
                    end
                end

                respond_to do |format|
                    format.html { redirect_to admin_products_url }
                    format.js { render plain: 'Ok' }
                end
            end

            protected


            def collection
                return @collection if @collection.present?

                params[:q] ||= {}
                params[:q][:deleted_at_null] ||= '1'
                params[:q][:not_discontinued] ||= '1'

                params[:q][:s] ||= 'position asc'
                @collection = super
                # Don't delete params[:q][:deleted_at_null] here because it is used in view to check the
                # checkbox for 'q[deleted_at_null]'. This also messed with pagination when deleted_at_null is checked.
                if params[:q][:deleted_at_null] == '0'
                    @collection = @collection.with_deleted
                end
                # @search needs to be defined as this is passed to search_form_for
                # Temporarily remove params[:q][:deleted_at_null] from params[:q] to ransack products.
                # This is to include all products and not just deleted products.
                @search = @collection.ransack(params[:q].reject { |k, _v| k.to_s == 'deleted_at_null' })
                @collection = @search.result.
                        includes(product_includes).
                        page(params[:page]).
                        per(params[:per_page] || Spree::Config[:admin_products_per_page])

                unless params[:q][:s].include? 'master_default_price_amount'
                    @collection = @collection.reorder("spree_products.#{params[:q][:s]}")
                end

                @collection
            end
        end
    end

end

::Spree::Admin::ProductsController.prepend Spree::Admin::ProductsControllerDecorator if ::Spree::Admin::ProductsController.included_modules.exclude? Spree::Admin::ProductsControllerDecorator