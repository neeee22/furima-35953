class ItemsController < ApplicationController
  def index
  end
  def new
   @item = Item.new
  end

  private 
  def item_params
    params.require(:item).permit(:name,
                                 :price,
                                 :detail,
                                 :category_id,
                                 :status_id,
                                 :delivery_charge_id,
                                 :prefectue_id,
                                 :shipping_date_id,
                                 :image ).marge(user_id: current_user.id)
  end
end
