class ExceptionsController < ApplicationController
  def bad_request
    render status: 400
  end

  def not_authorized
    render status: 401
  end

  def not_found
    render status: 404
  end

  def unprocessable_entity
    render status: 422
  end

  def internal_server_error
    render status: 500
  end
end
