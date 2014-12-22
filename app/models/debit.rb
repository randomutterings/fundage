# A debit reduces a wallet's balance. For normal wallets,
# the balance must be greater than or equal to 0 after
# the transaction completes.
class Debit < Amount
  def funded?
    wallet.can_fund?(amount)
  end
end
