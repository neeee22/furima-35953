class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_index

  def index
    @order_address = OrderAddress.new
    show_card
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      show_card
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @item.price,
      customer: customer_token,
      currency: 'jpy'
    )
  end

  def move_to_index
    redirect_to root_path if @item.user == current_user || @item.order.present?
  end

  def show_card
    @user = current_user
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    card = Card.find_by(user_id: current_user.id)
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_token) 
      @card = customer.cards.first
    end
  end
end
