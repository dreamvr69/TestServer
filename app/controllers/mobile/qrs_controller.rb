require 'exceptions/qr/qr_too_frequent_use_by_client_exception'
require 'exceptions/qr/qr_too_frequent_use_exception'
require 'exceptions/qr/qr_too_much_today_usage_by_client_exception'
require 'exceptions/qr/qr_too_much_today_usage_exception'
require 'exceptions/qr/qr_too_much_usage_by_client_exception'
require 'exceptions/qr/qr_too_much_usage_exception'

class Mobile::QrsController < Mobile::BaseController
  before_action :set_qr, only: :charge
  before_action :authenticate_user!

  swagger_controller :qrs, 'QR Management'

  swagger_api :charge do
    summary 'Charge QR by id'
    param :header, 'Authorization', :string, :required, 'Authentication token'
    param :path, :id, :string, :required, 'QR id'
    response 201
    response :not_found
    response 601, 'Qr Too Frequent Use By Client Exception'
    response 602, 'Qr Too Frequent Use Exception'
    response 603, 'Qr Too Much Today Usage By Client Exception'
    response 604, 'Qr Too Much Today Usage Exception'
    response 605, 'Qr Too Much Usage By Client Exception'
    response 606, 'Qr Too Much Usage Exception'
  end

  def charge
    begin
      score   = @qr.charge(@current_user)
      loyalty = @current_user.loyalty
      loyalty.score += score.to_i
      loyalty.save!
      respond_with @current_user, serializer: Mobile::UserSerializer, location: false
    rescue QrTooFrequentUseByClientException
      head 601
    rescue QrTooFrequentUseException
      head 602
    rescue QrTooMuchTodayUsageByClientException
      head 603
    rescue QrTooMuchTodayUsageException
      head 604
    rescue QrTooMuchUsageByClientException
      head 605
    rescue QrTooMuchUsageException
      head 606
    end
  end

  private
    def set_qr
      @qr = Qr.find params[:id]
    end
end
