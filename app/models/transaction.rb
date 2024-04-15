# == Schema Information
#
# Table name: transactions
#
#  id          :uuid             not null, primary key
#  amount      :decimal(19, 4)   not null
#  currency    :string           default("USD"), not null
#  date        :date             not null
#  excluded    :boolean          default(FALSE)
#  name        :string
#  notes       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :uuid             not null
#  category_id :uuid
#
# Indexes
#
#  index_transactions_on_account_id   (account_id)
#  index_transactions_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id) ON DELETE => cascade
#  fk_rails_...  (category_id => transaction_categories.id) ON DELETE => nullify
#
class Transaction < ApplicationRecord
  include Monetizable

  belongs_to :account
  belongs_to :category, optional: true

  validates :name, :date, :amount, :account, presence: true

  monetize :amount

  scope :inflows, -> { where("amount > 0") }
  scope :outflows, -> { where("amount < 0") }
  scope :active, -> { where(excluded: false) }

  def self.ransackable_attributes(auth_object = nil)
    %w[name amount date]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category account]
  end

  def self.build_filter_list(params, family)
    filters = []

    if params
      params.each do |key, value|
        next if value.blank?

        case key
        when "account_id_in"
          value.each do |account_id|
            filters << { type: "account", value: family.accounts.find(account_id), original: { key: key, value: account_id } }
          end
        when "category_id_in"
          value.each do |category_id|
            filters << { type: "category", value: family.transaction_categories.find(category_id), original: { key: key, value: category_id } }
          end
        when "category_name_or_account_name_or_name_cont"
          filters << { type: "search", value: value, original: { key: key, value: nil } }
        end
      end
    end

    filters
  end
end
