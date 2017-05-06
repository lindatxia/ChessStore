class PurchasesController < ApplicationController
  before_action :check_login
  authorize_resource
  
  def index
    @purchases = Purchase.chronological.to_a
  end

  def new
    @purchase = Purchase.new
    @item_id = params[:item_id]
  end

  def create
    
    @purchase = Purchase.new(purchase_params)
    @purchase.date = Date.current

    respond_to do |format|
      
      if @purchase.save      
        format.html { redirect_to purchases_path, notice: 'Successfully added a purchase for #{@purchase.quantity} #{@purchase.item.name}.' }
        @reorder_items = Item.all.need_reorder.alphabetical.to_a
        format.js 
      else
        format.html { render action: 'new' }
      end
    end
  
  end

  private
  def purchase_params
    params.require(:purchase).permit(:item_id, :quantity)
  end
  
end