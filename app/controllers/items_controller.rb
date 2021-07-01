class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :set_item, only: %i[show edit update]
  before_action :edit_authority, only: %i[edit update]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
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
                                 :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def edit_authority
    # 商品購入機能実装時にコメントアウトを外す
    redirect_to root_path if current_user != @item.user # || @item.order.present?
  end
end
