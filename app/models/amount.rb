# Amounts should only be created through their associated entry
class Amount < ActiveRecord::Base
  belongs_to :entry
  belongs_to :wallet

  validates_presence_of :type, :entry, :wallet
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :check_funds

  delegate :name, to: :wallet
  delegate :from, to: :entry
  delegate :to, to: :entry

  private

  def check_funds
    errors[:amount] << 'Dude, Need Fundage, Bro' unless funded?
  end

  def funded?
    true # override for debits
  end
end
