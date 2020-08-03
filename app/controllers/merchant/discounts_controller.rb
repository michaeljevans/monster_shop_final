class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = Merchant.find(current_user.merchant_id).discounts
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @discount = Discount.new
  end

  def create
    @discount = Merchant.find(params[:merchant_id]).discounts.new(discount_params)
    if @discount.save
      flash[:success] = 'Discount created!'
      redirect_to '/merchant/discounts'
    else
      flash[:error] = 'All fields are required to create a new discount.'
      render :new
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    @discount.update(discount_params)
    if @discount.save
      flash[:success] = 'Discount updated!'
      redirect_to "/merchant/discounts/#{@discount.id}"
    else
      flash[:error] = 'All fields are required to update discount information.'
      render :edit
    end
  end

  private

  def discount_params
    params.require(:discount).permit(:percentage, :items_required)
  end
end
