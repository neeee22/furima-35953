class ItemsController < ApplicationController
  def index
  end

  def new
    if user_signed_in?
      @item = Item.new
    else
      render :index
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end
  private 
  def item_params
    params.require(:item).permit(:name,
                                 :price,
                                 :detail,
                                 :category_id,
                                 :status_id,
                                 :fee_id,
                                 :prefecture_id,
                                 :schedule_id,
                                 :image ).merge(user_id: current_user.id)
  end
end
