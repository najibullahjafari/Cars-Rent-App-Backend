# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    respond_to :json
    
    private

    def respond_with(resource, _opts = {})
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
        jwt_token: generate_jwt_token(resource)
      }, status: :ok
    end

    def respond_to_on_destroy
      if current_user
        render json: {
          status: 200,
          message: 'logged out successfully'
        }, status: :ok
      else
        render json: {
          status: 401,
          message: "Couldn't find an active session."
        }, status: :unauthorized
      end
    end

    private

    def generate_jwt_token(_resource)
      token = request.env['warden-jwt_auth.token']
      token if token.present?
    end
  end
end
