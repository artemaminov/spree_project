# frozen_string_literal: true

Deface::Override.new(
  virtual_path: 'spree/layouts/admin',
  insert_bottom: '#main-sidebar',
  partial: 'spree/admin/shared/menu/page_design_tab',
  name: 'page_design_tab'
)
