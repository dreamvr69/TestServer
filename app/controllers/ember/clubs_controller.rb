class Ember::ClubsController < Ember::BaseController
  before_action :authenticate_user!

  def create
    build_item
    authorize(@item)
    form = get_form
    if form.present?
      if form.validate(permitted_params)
        form.save
      else
        return respond_with(form)
      end
    else
      @item.save
    end
    if @current_user.selected_club.nil?
      @current_user.selected_club == @item
      @current_user.save!
    end
    yield(@item) if block_given?
    respond_with(@item, serializer: serializer, location: false, root: root_name)
  end

  def update
    authorize(@item)
    if params[:club][:service_ids].nil?
      params[:club][:service_ids] = []
    end
    form = get_form
    if form.present?
      if form.validate(permitted_params)
        form.save
      else
        return respond_with(form)
      end
    else
      @item.update(permitted_params)
    end
    yield(@item) if block_given?
    respond_with(@item, location: false)
  end

end
