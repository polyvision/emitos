module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def button_link(label_txt,controller_stuff,icon_stuff = false,class_xtra = false)
    if icon_stuff == false
      label = label_txt
    else
      label = "<i class=\"#{icon_stuff}\"></i> #{label_txt}"
    end
    
    class_str = "btn btn-primary"
    if class_xtra
      class_str << " " << class_xtra
    end

    return link_to(raw(label),controller_stuff,{:class => class_str})
  end

  def button_link_confirm(label_txt,controller_stuff,icon_stuff = false,confirm_text = false)
    if icon_stuff == false
      label = label_txt
    else
      label = "<i class=\"#{icon_stuff}\"></i> #{label_txt}"
    end
    
    return link_to(raw(label),controller_stuff,{:class => 'btn btn-primary',:confirm => confirm_text})
  end
end
