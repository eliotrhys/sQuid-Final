require('sinatra')
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')

get '/tags/by_tag' do #TRANSACTIONS BY TAG
  @tags = Tag.all
  erb(:"tags/by_tag")
end

get '/tags/by_tag/:id' do #TRANSACTIONS BY TAG
  @transaction_result = Transaction.by_tag(params[:id])
  erb(:"tags/by_tag_id")
end
