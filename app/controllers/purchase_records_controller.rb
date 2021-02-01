class PurchaseRecordsController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!, only: [:index, :create]
  before_action :for_root, only: [:index, :create]
  

  def index
    @record_add = RecordAdd.new
  end

  def create
    @record_add = RecordAdd.new(purchase_records_params)

    if @record_add.valid?
      pay
      @record_add.save

      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def purchase_records_params
    params.require(:record_add).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building, :phone).merge(
      user: current_user.id, item: params[:item_id], token: params[:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_records_params[:token],
      currency: 'jpy'
    )
  end

  def for_root
    redirect_to root_path if current_user.id == @item.user_id || @item.purchase_record.present?
  end

end
