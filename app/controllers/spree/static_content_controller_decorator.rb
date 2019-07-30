# frozen_string_literal: true

Spree::StaticContentController.class_eval do
  def show
    @page = Spree::StaticPage.finder_scope.by_store(current_store).find_by!(slug: request.path)
    @parent = @page.parent_id ? Spree::StaticPage.finder_scope.by_store(current_store).find(@page.parent_id) : nil
    parent_id = @parent ? @parent.id : @page.id
    @children = Spree::StaticPage.finder_scope.by_store(current_store).where(parent_id: parent_id).order(:parent_position)
  end
end
