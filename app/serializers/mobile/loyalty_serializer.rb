class Mobile::LoyaltySerializer < ActiveModel::Serializer
  attributes :id, :score, :franchise_id, :level

  def level
    @object.level
  end

end
