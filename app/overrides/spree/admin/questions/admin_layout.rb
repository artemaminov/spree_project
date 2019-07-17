Deface::Override.new(
    virtual_path:  'spree/layouts/admin',
    name:          'questions_main_menu_tabs',
    insert_bottom: '#main-sidebar',
    text:       <<-HTML
    <% if current_spree_user.respond_to?(:has_spree_role?) && current_spree_user.has_spree_role?(:admin) %>
      <ul class="nav nav-sidebar">
        <%= tab plural_resource_name(Spree::Question), url: admin_questions_path, icon: 'question-sign' %>
      </ul>
    <% end %>
HTML
)