Deface::Override.new(
    virtual_path: 'spree/admin/pages/_form',
    name: 'parents_info',
    insert_bottom: 'div[data-hook="admin_page_form_right"]' ,
    partial: 'spree/static_content/edit_form_parents'
)