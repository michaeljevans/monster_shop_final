class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = Merchant.find(current_user.merchant_id).discounts
  end

  def show
    @discount = Discount.find(params[:id])
  end
end
