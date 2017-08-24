class Mobile::ClientDevisesController < Mobile::BaseController
  swagger_controller :client_devises, 'Client Devise Management'

  swagger_api :create do
    summary 'Add devise to user'
    param :header, 'Authorization', :string, :required, 'Authentication token'
    param :query, :token, :string, :required, 'devise token'
    param :query, :os_type, :string, :required, 'OS type (ios, android)'
    param :query, :user_id, :string, :required, 'user_id'
    response :ok
  end

end
