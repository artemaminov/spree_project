# frozen_string_literal: true

module PagesHelper
  def add_object_link(name, form, object, partial, where)
    html = render(partial: partial, locals: { form: form, file: object })
    link_to_function name, %{
      var new_object_id = new Date().getTime();
      var html = $(#{html.to_json}.replace(/index_to_replace_with_js/g, new_object_id)).hide();
      html.appendTo($("#{where}")).slideDown('slow');
      var formatDate = $( "input.datepicker" ).datepicker( "option", "dateFormat" );
      $( "input.datepicker#" + new_object_id ).datepicker();
      $( "input.datepicker#" + new_object_id ).datepicker( "option", "dateFormat", formatDate );
    }
  end

  def link_to_function(name, *args, &block)
    html_options = args.extract_options!.symbolize_keys

    function = block_given? ? update_page(&block) : args[0] || ''
    onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || '#'

    content_tag(:a, name, html_options.merge(href: href, onclick: onclick))
  end
end
