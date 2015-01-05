# Entries are the records of debits and credits to various wallets
# In accountant speak, they're 'entries' in the 'Journal' or 'Ledger'
class Entry < ActiveRecord::Base
  has_many :credits, inverse_of: :entry
  has_many :debits, inverse_of: :entry

  validates_presence_of :credits, :debits
  validates_associated :credits, :debits
  validate :check_balance

  accepts_nested_attributes_for :credits, :debits

  # these will need to be refactored if we decide to
  # support multiple debits and credits per entry
  def from
    debits.first.name
  end

  def to
    credits.first.name
  end

  private

  def check_balance
    errors[:base] << 'The entry is out of balance, please check the amounts' unless balanced?
  end

  def balanced?
    credit_balance == debit_balance
  end

  def credit_balance
    credits.map(&:amount).inject(:+)
  end

  def debit_balance
    debits.map(&:amount).inject(:+)
  end
end
