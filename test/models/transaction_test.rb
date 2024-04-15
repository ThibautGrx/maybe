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
require "test_helper"

class TransactionTest < ActiveSupport::TestCase
end
