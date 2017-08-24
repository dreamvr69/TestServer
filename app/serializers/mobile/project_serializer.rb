class Mobile::ProjectSerializer < ActiveModel::Serializer
    attributes :id

    def author_name
      User.find(user_id).
    end
end
