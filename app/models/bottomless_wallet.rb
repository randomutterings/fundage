# Bottomless Wallets are special wallets for external money sources.
# This is the mechanism we use for getting money in and out of the system.
# In accounting speak, you would create 'revenue wallets'
# to track income and 'expense wallets' to track expenditures.
# Since Bottomless Wallets are external, we assume they always have funds available.
class BottomlessWallet < Wallet
  def can_fund?(_amount)
    true
  end
end
