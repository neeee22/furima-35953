class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  
  def show
    @user = current_user
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    card = Card.find_by(user_id: current_user.id)
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_token) 
      @card = customer.cards.first
    end
  end
  private
  
end

