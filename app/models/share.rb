class Share
  include Mongoid::Document
  include Mongoid::Timestamps
  
  extend Enumerize

  TYPES = [:twitter, :vk, :instagram, :facebook]
  enumerize :type, in: TYPES

  belongs_to :user
  belongs_to :club
end
