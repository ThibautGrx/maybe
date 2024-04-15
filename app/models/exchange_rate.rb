# == Schema Information
#
# Table name: exchange_rates
#
#  id                 :uuid             not null, primary key
#  base_currency      :string           not null
#  converted_currency :string           not null
#  date               :date
#  rate               :decimal(, )
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_exchange_rates_on_base_converted_date_unique  (base_currency,converted_currency,date) UNIQUE
#  index_exchange_rates_on_base_currency               (base_currency)
#  index_exchange_rates_on_converted_currency          (converted_currency)
#
class ExchangeRate < ApplicationRecord
  include Provided

  validates :base_currency, :converted_currency, presence: true

  class << self
    def find_rate(from:, to:, date:)
      find_by \
        base_currency: Money::Currency.new(from).iso_code,
        converted_currency: Money::Currency.new(to).iso_code,
        date: date
    end

    def find_rate_or_fetch(from:, to:, date:)
      find_rate(from:, to:, date:) || fetch_rate_from_provider(from:, to:, date:).tap(&:save!)
    end

    def get_rate_series(from, to, date_range)
      where(base_currency: from, converted_currency: to, date: date_range).order(:date)
    end
  end
end
