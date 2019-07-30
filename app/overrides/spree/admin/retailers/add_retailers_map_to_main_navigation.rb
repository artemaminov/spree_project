# frozen_string_literal: true

Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  insert_bottom: '#main-sidebar',
  partial: 'spree/admin/shared/map_retailers_tab',
  name: 'map_retailers_tab'
)
