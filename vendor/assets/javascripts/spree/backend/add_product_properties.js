$(document).ready(function () {

  let uniqueId = 1;

  let $cloneSelect = $('#product_properties tr:visible:last');
  $cloneSelect.hide();

  let $spreeAddFields = $('.spree_add_fields');
  $spreeAddFields.off();

  $spreeAddFields.click(function () {
    $cloneSelect.find('select.select2.select2-offscreen').select2('destroy');
    let target = $(this).data('target');
    let $newTableRow = $(target + ' tr:hidden:first').clone();
    let newId = new Date().getTime() + (uniqueId++);
    $newTableRow.find('input, select').each(function () {
      let el = $(this);
      el.val('');
      el.prop('id', el.prop('id').replace(/\d+/, newId));
      el.prop('name', el.prop('name').replace(/\d+/, newId));
    });

    $newTableRow.find('a').each(function () {
      let el = $(this);
      el.prop('href', '#');
    });

    $newTableRow.find('select').select2();
    $newTableRow.show();
    $(target).prepend($newTableRow);
  });
});
