require('sinatra')
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')

get '/merchants/by_merchant' do #TRANSACTIONS BY MERCHANT
  @merchants = Merchant.all
  erb(:"merchants/by_merchant")
end

get '/merchants/by_merchant/:id' do #TRANSACTIONS BY MERCHANT
  @transaction_result = Transaction.by_merchant(params[:id])
  erb(:"merchants/by_merchant_id")
end

get '/new_merchant' do #NEW
  erb(:"merchants/new")
end

post '/merchants/by_merchant' do #CREATE
  merchant = Merchant.new(params)
  merchant.save
  redirect to ("/merchants/by_merchant")
end
