class Users::DeviseController < ApplicationController

  class Responder < ActionController::Responder

    def to_turbo_stream
      controller.render(options.merge(formats: :html))
    rescue ActionView::MissingTemplate => error_messages
      if get?
        raise error
      elsif has_errors? && default_action
        render rendering_options.merge(formats: :html, status: :unprocessable_entity)
      else
        redirect_to navigation_location
      end
    end

  end

  self.responder = responder
  respond_to :html, :turbo_stream

end
