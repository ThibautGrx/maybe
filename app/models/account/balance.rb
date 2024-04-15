# == Schema Information
#
# Table name: account_balances
#
#  id         :uuid             not null, primary key
#  balance    :decimal(19, 4)   not null
#  currency   :string           default("USD"), not null
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#
# Indexes
#
#  index_account_balances_on_account_id                       (account_id)
#  index_account_balances_on_account_id_date_currency_unique  (account_id,date,currency) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id) ON DELETE => cascade
#
class Account::Balance < ApplicationRecord
    include Monetizable

    belongs_to :account
    validates :account, :date, :balance, presence: true
    monetize :balance
    scope :in_period, ->(period) { period.date_range.nil? ? all : where(date: period.date_range) }
end
