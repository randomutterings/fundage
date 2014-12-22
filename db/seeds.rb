# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
pbacon = User.create!(name: 'Princess Bacon')
pbacon_wallet = Wallet.create!(owner: pbacon)

spano = User.create!(name: 'The Spandex Nomad')
spano_wallet = Wallet.create!(owner: spano)

mmse = Team.create!(name: 'The Mighty Morphin Stock Exchangers')
mmse_wallet = BottomlessWallet.create!(owner: mmse)

pp = Team.create!(name: 'The Puxatony Phils')
pp_wallet = Wallet.create!(owner: pp)

Entry.create!({
  debits: [Debit.new(amount: 1001.73, wallet: mmse_wallet)],
  credits: [Credit.new(amount: 1001.73, wallet: pbacon_wallet)]
})

Entry.create!({
  debits: [Debit.new(amount: 1056.20, wallet: mmse_wallet)],
  credits: [Credit.new(amount: 1056.20, wallet: spano_wallet)]
})

Entry.create!({
  debits: [Debit.new(amount: 1111.11, wallet: mmse_wallet)],
  credits: [Credit.new(amount: 1111.11, wallet: pp_wallet)]
})

Entry.create!({
  debits: [Debit.new(amount: 500.42, wallet: pbacon_wallet)],
  credits: [Credit.new(amount: 500.42, wallet: spano_wallet)]
})

Entry.create!({
  debits: [Debit.new(amount: 400.42, wallet: spano_wallet)],
  credits: [Credit.new(amount: 400.42, wallet: pp_wallet)]
})

Entry.create!({
  debits: [Debit.new(amount: 300.42, wallet: pp_wallet)],
  credits: [Credit.new(amount: 300.42, wallet: pbacon_wallet)]
})

Entry.create!({
  debits: [Debit.new(amount: 200.42, wallet: pbacon_wallet)],
  credits: [Credit.new(amount: 200.42, wallet: mmse_wallet)]
})
