# == Schema Information
#
# Table name: valuations
#
#  id         :uuid             not null, primary key
#  currency   :string           default("USD"), not null
#  date       :date             not null
#  value      :decimal(19, 4)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :uuid             not null
#
# Indexes
#
#  index_valuations_on_account_id           (account_id)
#  index_valuations_on_account_id_and_date  (account_id,date) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id) ON DELETE => cascade
#
class Valuation < ApplicationRecord
  include Monetizable

  belongs_to :account
  validates :account, :date, :value, presence: true
  monetize :value

  scope :in_period, ->(period) { period.date_range.nil? ? all : where(date: period.date_range) }

  def self.to_series
    TimeSeries.from_collection all, :value_money
  end
end
