class UserStocksController < ApplicationController

   def destroy
     stock = Stock.find(params[:id])
     user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
     user_stock.destroy
     flash[:notice] = "#{stock.ticker} was successfully removed from portfolio"
     redirect_to my_portfolio_path
   end


  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end

  def update
      stock = Stock.find(params[:id])
      stock_price = Stock.new_lookup(stock.ticker)
      stock.last_price = stock_price.last_price
      stock.save
    redirect_to my_portfolio_path
  end


end
