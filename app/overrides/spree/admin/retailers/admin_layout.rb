Deface::Override.new(
  virtual_path:  'spree/layouts/admin',
  name:          'retailers_main_menu_tabs',
  insert_bottom: '#main-sidebar',
  text:       <<-HTML
            <% if current_spree_user.respond_to?(:has_spree_role?) && current_spree_user.has_spree_role?(:admin) %>
              <ul class="nav nav-sidebar">
                <%= tab plural_resource_name(Spree::Retailer), url: admin_retailers_path, icon: 'money' %>
              </ul>
            <% end %>
            HTML
)