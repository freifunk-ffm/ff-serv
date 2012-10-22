module ApplicationHelper
  def icon_tag(img, tooltip)
    image_tag "silk/#{img}.png", :alt => img, :title => tooltip
  end
  def read_only(form)
    model = form.object
    method = form.options[:html][:method]
    logger.debug "Role: #{current_user.role_symbols}"
    if(method == :put)
      logger.debug "!#{model}.permitted_to? :update = #{!model.permitted_to? :update}"
      return(!model.permitted_to? :update)
    else
      logger.debug "!#{model}.permitted_to? :create = #{!model.permitted_to? :create}"
      return(!model.permitted_to? :create)
    end
  end
end
