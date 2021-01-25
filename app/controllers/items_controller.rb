class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :show, :update]
  def index
    @items = Item.all.order(created_at: :desc)
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

  def show 
  end

  def edit
    if user_signed_in? && current_user.id == Item.find(params[:id]).user_id
    else
      redirect_to root_path
    end
  end

  def update
    if user_signed_in? && current_user.id == Item.find(params[:id]).user_id
      @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private

  # 商品投稿時のストロングパラメータ  下記カラムの値のみ取得を許可する
  def item_params
    params.require(:item).permit(:name, :info, :category_id, :status_id, :shipping_cost_burden_id, :prefecture_id,
                                 :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end