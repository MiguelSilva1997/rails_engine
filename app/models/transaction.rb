class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :success, ->{ where(result: 'success') }
  scope :failure, ->{ where(result: 'failure') }

  def self.find_all(params)
    where(params)
  end

  def self.find_transaction(params)
    find_by(params)
  end
end
