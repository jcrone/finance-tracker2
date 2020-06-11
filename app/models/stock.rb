class Stock < ApplicationRecord
  before_save { self.ticker = ticker.upcase }
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true,
            uniqueness: { case_sensitive: false }

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex[:sandbox_api_key],
      endpoint: 'https://sandbox.iexapis.com/v1')
    begin
      new(ticker: ticker_symbol.upcase, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

 def update_pricing
   @user = current_user
   @tracked_stock = @user.stocks
 end

end
