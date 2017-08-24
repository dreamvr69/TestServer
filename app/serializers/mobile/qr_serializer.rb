class Mobile::QrSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :score, :usage_frequency_for_client, :usage_frequency, :usage_limit_per_day_for_client,
             :usage_limit_per_day, :usage_limit_for_client, :usage_limit, :code_url, :club_id

  def code_url
    if Rails.env.development?
      "http://localhost:3000#{@object.code_url}"
    else
      "http://api.fitclubs.nsuask.ru#{@object.code_url}"
    end
  end
end
