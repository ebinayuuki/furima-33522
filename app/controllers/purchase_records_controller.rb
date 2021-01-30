class PurchaseRecordsController < ApplicationController
  before_action :set_item


  def index
    @record_add = RecordAdd.new
  end

  def create  
  
    @record_add = RecordAdd.new(purchase_records_params)
   
    if @record_add.valid?
      @record_add.save
      
       redirect_to root_path
    else  
      render action: :index
    end
  end


  private

  def purchase_records_params
    params.require(:record_add).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building, :phone).merge(user: current_user.id, item: params[:item_id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
