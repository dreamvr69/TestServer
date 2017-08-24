class Loyalty
  include Mongoid::Document
  include Mongoid::Timestamps

  field :score, type: Integer, default: 0

  def level
    if self.user.selected_club.fifth_level_min_score <= self.score
      5
    else
      if self.user.selected_club.fourth_level_min_score <= self.score
        4
      else
        if self.user.selected_club.third_level_min_score <= self.score
          3
        else
          if self.user.selected_club.second_level_min_score <= self.score
            2
          else
            if self.user.selected_club.first_level_min_score <= self.score
              1
            else
              0
            end
          end
        end
      end
    end
  end

  belongs_to :franchise
  has_one    :user
end
