ActionView::Base.field_error_proc = proc do |html_tag, instance_tag|
  fragment = Nokogiri::HTML.fragment(html_tag)
  field = fragment.at("input,select,textarea")

  html = if field
    field["class"] = "#{field["class"]} !border-red-400"
    html = <<-HTML
              #{fragment}
    <p class="text-red-400">#{instance_tag.instance_variable_get(:@method_name).humanize} #{instance_tag&.error_message&.first}</p>
    HTML
    html
  else
    html_tag
  end

  html.html_safe
end
