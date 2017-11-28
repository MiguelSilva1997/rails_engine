class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices

  def self.find_all(params)
    where(params)
  end

  def self.find_merchant(params)
    find_by(params)
  end

  def self.find_random
    all.sample
  end

  def self.revenue
  end
end
