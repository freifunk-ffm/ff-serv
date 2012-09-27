module ApplicationHelper
  def icon_tag(img, tooltip)
    image_tag "silk/#{img}.png", :alt => img, :title => tooltip
  end
  def read_only(form)
    model = form.object
    method = form.options[:html][:method]
    if(method == :put)
      model.permitted_to? :update
    else
      model.permitted_to? :create
    end
  end
end
