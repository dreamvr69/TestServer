class QrCharge
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :qr
end
