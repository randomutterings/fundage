# Owner is the parent class of any entity could have a wallet
class Owner < ActiveRecord::Base
  has_one :wallet, dependent: :destroy
  has_many :credits, through: :wallet, dependent: :restrict_with_error
  has_many :debits, through: :wallet, dependent: :restrict_with_error

  validates_presence_of :name

  delegate :balance, to: :wallet
end
