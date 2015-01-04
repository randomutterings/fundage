# Wallets are containers for tracking money internal to the system.
# In accounting speak, these are asset accounts
class Wallet < ActiveRecord::Base
  belongs_to :owner
  has_many :credits, dependent: :restrict_with_error
  has_many :debits, dependent: :restrict_with_error

  validates_presence_of :owner

  delegate :name, to: :owner

  def balance
    credits.sum(:amount) - debits.sum(:amount)
  end

  def can_fund?(amount)
    amount && balance - amount >= 0
  end
end
