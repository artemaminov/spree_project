module Spree
  module Admin
    #
    # TODO Для корректного отображения в шаблоне, вставить в "ПЕРЕЧИСЛИТЕ ИДЕНТИФИКАТОРЫ ЭЛЕМЕНТОВ TEXTAREA ЧЕРЕЗ ПРОБЕЛ" визуального редактора (admin/editor_settings/edit) - page_section_description page_section_title
    #
    class PageSectionsController < ResourceController
      update.before :update_before

      def create
        @page_section = PageSection.build(params[:page_section].except(:icon))
        @page_section.build_image(attachment: page_section_params[:icon])
        if @page_section.save
          respond_with(@page_section) do |format|
            format.json { render json: @page_section.to_json }
          end
        else
          flash[:error] = Spree.t('errors.messages.could_not_create_taxon')
          respond_with(@page_section) do |format|
            format.html { redirect_to @taxonomy ? edit_admin_taxonomy_url(@taxonomy) : admin_taxonomies_url }
          end
        end
      end

      def update_before
        # byebug
        image = permitted_resource_params.delete :image
        @object.build_image attachment: image
      end

      def edit; end

      def translate
        section = Spree::PageSection.find(params[:id])
        section.update update_page_section_attribute
        redirect_to spree.admin_page_sections_path
      end

      private
      def update_page_attribute
        params.require(:page_section).permit(permitted_params)
      end

      def permitted_params
        [:translations_attributes => [:id, :title, :description, :html_section_name, :button_text, :button_url, :html_section_name, :button_style, :button_centered, image: [:id]]]
      end
    end
  end
end
