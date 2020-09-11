# frozen_string_literal: true

module Spree
  module Admin
    class GalleriesController < ResourceController
      def update_positions
        ApplicationRecord.transaction do
          per_page = params[:per_page] || 25
          page = params[:page] || 1

          params[:positions].each do |id, index|
            Spree::Gallery.where(id: id).update_all(position: index.to_i + per_page.to_i * (page.to_i - 1))
          end
        end

        respond_to do |format|
          format.html { redirect_to admin_galleries_url }
          format.js { render plain: 'Ok' }
        end
      end

      def update_images_position
        params[:spree_attachment].each_with_index do |id, index|
          ActiveStorage::Attachment.where(id: id).update_all(position: index + 1)
        end

        head :ok
      end

      def file_upload
        files = params[:files]

        single = params[:single] == 'true'
        name = params[:name]

        @uploaded = []

        files.each do |file|
          file = EntityFile.create({
                                    entity: 'Gallery',
                                    name: 'temp_file',
                                    image: file
                            })

          # file.image.variant(resize: '810x550>')
          # image.variant(resize_to_limit: [810, 550])

          @uploaded << file.image
        end

        if single
          render 'render_big_image', locals: {
                  content: {
                          name: name
                  }
          }
        else
          render 'render_file_item', locals: {
                  content: {
                          name: name
                  }
          }
        end

      end

      def index
        # super

        @galleries = Spree::Gallery.all
                             .reorder(position: :asc)
                             # .page(params[:page])
      end

      def create
        products = products_params_multiple[:products]

        unless products.nil?
          @gallery.products << Spree::Product.find(products.reject(&:empty?))
        end

        params[:gallery].delete(:products)

        if params.key? :main_image
          @gallery.main_image.attach(ActiveStorage::Attachment.find(params[:main_image]).blob)
        end

        if params.key? :preview_image
          @gallery.preview_image.attach(ActiveStorage::Attachment.find(params[:preview_image]).blob)
        end

        if params.key? :images
          params[:images].each do |id|
            @gallery.images.attach(ActiveStorage::Attachment.find(id).blob)
          end
        end

        super
      end

      def update
        products = products_params_multiple[:products]

        unless products.nil?
          @gallery.products.destroy_all
          @gallery.products << Spree::Product.find(products.reject(&:empty?))
        end

        params[:gallery].delete(:products)

        if params.key? :main_image
          @gallery.main_image.destroy if @gallery.main_image.attached?

          @gallery.main_image.attach(ActiveStorage::Attachment.find(params[:main_image]).blob)
        end

        if params.key? :preview_image
          @gallery.preview_image.destroy if @gallery.preview_image.attached?

          @gallery.preview_image.attach(ActiveStorage::Attachment.find(params[:preview_image]).blob)
        end

        if params.key? :images
          @gallery.images.destroy_all

          params[:images].each do |id|
            @gallery.images.attach(ActiveStorage::Attachment.find(id).blob)
          end
        end

        super
      end

      def translate
        gallery = Spree::Gallery.find(params[:id])
        gallery.update update_page_attribute
        redirect_to spree.admin_galleries_path
      end

      private

      def find_resource
        Spree::Gallery.find(params[:id])
      end

      def collection
        params[:q] = {} if params[:q].blank?
        news = super.order(created_at: :asc)
        @search = news.ransack(params[:q])

        @collection = @search.result
                              .page(params[:page])
                              .per(params[:per_page])
      end

      def update_page_attribute
        params.require(:gallery).permit(permitted_params)
      end

      def permitted_params
        [translations_attributes: %i[id title subtitle desc]]
      end

      def products_params_multiple
        params[:gallery].permit(products: [])
      end
    end
  end
end
