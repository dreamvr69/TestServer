class Ember::PushChannelsController < Ember::BaseController
  before_action :authenticate_user!

  def update
    authorize(@item)
    if params[:push_channel][:user_ids].nil?
      params[:push_channel][:user_ids] = []
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
