class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :set_render_cart
  before_action :initialize_cart

# before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

# Partials of code about shopping cart
  def set_render_cart
    @render_cart = true
  end
  def initialize_cart
    @cart ||= Cart.find_by(id: session[:cart_id])

    #Creation of cart
    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
      #@cart.save or #session[:cart_id].save
    end

  end


  protected

    def configure_permitted_parameters

      #devise_parameter_sanitizer.permit(:sign_up, keys: %i[role, first_name, last_name, age, sex, country, city, phone, address, email, password, password_confirmation ])
      #devise_parameter_sanitizer.permit(:account_update, keys: %i[role, first_name, last_name, age, sex, country, city, phone, address, email, password, password_confirmation, :photo ])

      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:role, :last_name, :first_name, :age, :sex, :country, :city, :phone, :address, :email, :password, :password_confirmation, :photo) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:role, :last_name, :first_name, :age, :sex, :country, :city, :phone, :address, :email, :password, :password_confirmation, :current_password, :photo) }


    end


end
