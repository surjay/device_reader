class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing, with: :invalid_params

  private

  def invalid_params(error)
    render_error(error.message)
  end

  def render_error(error_message, status: :unprocessable_entity)
    render json: { error: error_message }, status: status
  end
end
