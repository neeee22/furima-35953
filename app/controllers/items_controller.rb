class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_item, only: %i[show edit update destroy]
  before_action :edit_authority, only: %i[edit update]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = ItemBrand.new
  end

  def create
    @item = ItemBrand.new(item_params)
    binding.pry
    if @item.valid?
      @item.save
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

  def destroy
    if current_user == @item.user
      @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def item_params
    params.require(:item_brand).permit(:name, :price, :detail, :category_id, :status_id, :fee_id, :prefecture_id, :schedule_id, :brand_name, images: []).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def edit_authority
    redirect_to root_path if current_user != @item.user || @item.order.present?
  end
end
