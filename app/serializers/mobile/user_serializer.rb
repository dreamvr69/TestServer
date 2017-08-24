class Mobile::UserSerializer < ActiveModel::Serializer
  attributes :id, :name,  :email, :mobile, :club_ids, :franchise_id, :tutoring_ids, :workout_ids,
             :ticket_recall_ids, :ticket_freezing_ids, :ticket_extension_ids, :ticket_message_ids, :age, :sex

  has_one :loyalty, serializer: Mobile::LoyaltySerializer
  has_one :card,    serializer: Mobile::CardSerializer

  def waiting_rewards
    Mobile::RewardSerializer.new(@object.rewards.waiting)
  end

  def issued_rewards
    Mobile::RewardSerializer.new(@object.rewards.issued)
  end
end
