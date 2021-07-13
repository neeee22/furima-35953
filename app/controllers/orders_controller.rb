class OrdersController < ApplicationController
  before_action :set_item

  def index
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end
  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:postal_code,
                                          :prefecture,
                                          :city,
                                          :number,
                                          :building_name,
                                          :phone_number).merge(user_id: current_user.id,item_id: @item.id)
  end
end
