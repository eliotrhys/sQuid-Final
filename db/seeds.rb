require_relative('../models/merchant.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/wallet.rb')

the_wallet = Wallet.new({
  "wallet_amount" => 100
  })

the_wallet.save

tesco = Merchant.new({
  "merchant_name" => "TESCO"
  })
tesco.save

forbidden_planet = Merchant.new({
  "merchant_name" => "Forbidden Planet"
  })
forbidden_planet.save

the_shop_for_donkeys = Merchant.new({
  "merchant_name" => "The Shop For Donkeys"
  })
the_shop_for_donkeys.save



groceries = Tag.new({
  "tag" => "Groceries"
  })
groceries.save

comic_books = Tag.new({
  "tag" => "Comic Books"
  })
comic_books.save

donkey_feed = Tag.new({
  "tag" => "Donkey Feed"
  })
donkey_feed.save



transaction1 = Transaction.new({
  "amount" => 50,
  "merchant_id" => tesco.id,
  "tag_id" => groceries.id
  })
transaction1.save

transaction2 = Transaction.new({
  "amount" => 35,
  "merchant_id" => forbidden_planet.id,
  "tag_id" => comic_books.id
  })
transaction2.save
