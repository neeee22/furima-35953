class CardsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    session[:previous_url] = request.referer
  end
  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(
      description: 'test', 
      card: params[:card_token]
    )
    card = Card.new(
      card_token: params[:card_token],
      customer_token: customer.id,
      user_id: current_user.id
    )
    if card.save
      redirect_to session[:previous_url] 
    else
      render :new
    end
  end

  def destroy
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_token)
      customer.delete
      card.delete
    end
      redirect_to user_path(current_user)
  end
  
end
