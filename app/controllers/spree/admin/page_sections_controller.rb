module Spree
  module Admin
    #
    # TODO Для корректного отображения в шаблоне, вставить в "ПЕРЕЧИСЛИТЕ ИДЕНТИФИКАТОРЫ ЭЛЕМЕНТОВ TEXTAREA ЧЕРЕЗ ПРОБЕЛ" визуального редактора (admin/editor_settings/edit) - page_section_description page_section_title
    #
    class PageSectionsController < ResourceController

      def translate
        page_section = Spree::PageSection.find(params[:id])
        page_section.update update_page_section_attributes
        redirect_to spree.admin_page_sections_path
      end

      private
      def update_page_section_attributes
        params.require(:page_section).permit(permitted_params)
      end

      def permitted_params
        [:translations_attributes => [:id, :title, :description, :html_section_name, :button_text, :button_url, :button_style, :button_centered],
         :cropped_image_attributes => [:id, :attachment, croppers_attributes: [:id, :x, :y, :width, :height, :name]]]
      end
    end
  end
end
