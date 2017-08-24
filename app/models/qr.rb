require 'rqrcode'
require 'exceptions/qr/qr_too_frequent_use_by_client_exception'
require 'exceptions/qr/qr_too_frequent_use_exception'
require 'exceptions/qr/qr_too_much_today_usage_by_client_exception'
require 'exceptions/qr/qr_too_much_today_usage_exception'
require 'exceptions/qr/qr_too_much_usage_by_client_exception'
require 'exceptions/qr/qr_too_much_usage_exception'

class Qr
  include Mongoid::Document
  include Mongoid::Timestamps

  after_create :generate_qr

  field :name
  field :description
  field :score

  field :usage_frequency_for_client,     type: Integer, default: 0
  field :usage_frequency,                type: Integer, default: 0

  field :usage_limit_per_day_for_client, type: Integer, default: 0
  field :usage_limit_per_day,            type: Integer, default: 0

  field :usage_limit_for_client,         type: Integer, default: 0
  field :usage_limit,                    type: Integer, default: 0

  field :code_url

  belongs_to :club
  has_many   :qr_charges,                dependent: :destroy

  def charge(user)

    client_last_charge = QrCharge.where(user: user).order_by(created_at: 'desc').first
    last_charge = QrCharge.order_by(created_at: 'desc').first

    client_today_usage_counts = QrCharge.where(user: user, created_at: {gte: DateTime.now.utc.beginning_of_day,
                                                                        lte: DateTime.now.utc.end_of_day
    }).count

    today_usage_counts = QrCharge.where(created_at: {gte: DateTime.now.utc.beginning_of_day,
                                                     lte: DateTime.now.utc.end_of_day
    }).count

    client_usage_count = QrCharge.where(user: user).count
    usage_count        = QrCharge.count

    if client_last_charge.present?
      if (client_last_charge.created_at + self.usage_frequency_for_client.minutes) > DateTime.now
        raise QrTooFrequentUseByClientException
      end
    end

    if last_charge.present?
      if (last_charge.created_at + self.usage_frequency.minutes) > DateTime.now
        raise QrTooFrequentUseException
      end
    end

    if client_today_usage_counts == self.usage_limit_per_day_for_client
      raise QrTooMuchTodayUsageByClientException
    end

    if today_usage_counts == self.usage_limit_per_day
      raise QrTooMuchTodayUsageException
    end

    if client_usage_count == self.usage_limit_for_client
      raise QrTooMuchUsageByClientException
    end

    if usage_count == self.usage_limit
      raise QrTooMuchUsageException
    end

    QrCharge.create user: user, qr: self
    History::Score.create type: 'qr', score: self.score, client: user

    self.score
  end

  def generate_qr
    qrcode = RQRCode::QRCode.new("http://fitclubs.nsuask.ru/api/mobile/qrs/#{self.id}/charge")
    png = qrcode.as_png(
        resize_gte_to: false,
        resize_exactly_to: false,
        fill: 'white',
        color: 'black',
        size: 800,
        border_modules: 4,
        module_px_size: 6,
        file: nil
    )
    IO.binwrite("#{Rails.root}/public/system/#{self.id}.png", png.to_s)
    self.code_url = "/system/#{self.id}.png"
    self.save
  end

end
