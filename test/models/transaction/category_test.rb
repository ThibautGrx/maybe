# == Schema Information
#
# Table name: transaction_categories
#
#  id                :uuid             not null, primary key
#  color             :string           default("#6172F3"), not null
#  internal_category :string
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  family_id         :uuid             not null
#
# Indexes
#
#  index_transaction_categories_on_family_id  (family_id)
#
# Foreign Keys
#
#  fk_rails_...  (family_id => families.id)
#
require "test_helper"

class Transaction::CategoryTest < ActiveSupport::TestCase
  def setup
    @family = families(:dylan_family)
  end

  test "create_default_categories should generate categories if none exist" do
    @family.accounts.destroy_all
    @family.transaction_categories.destroy_all
    assert_difference "Transaction::Category.count", Transaction::Category::DEFAULT_CATEGORIES.size do
      Transaction::Category.create_default_categories(@family)
    end
  end

  test "create_default_categories should raise when there are existing categories" do
    assert_raises(ArgumentError) do
      Transaction::Category.create_default_categories(@family)
    end
  end

  test "updating name should clear the internal_category field" do
    category = Transaction::Category.take
    assert_changes "category.reload.internal_category", to: nil do
      category.update_attribute(:name, "new name")
    end
  end

  test "updating other field than name should not clear the internal_category field" do
    category = Transaction::Category.take
    assert_no_changes "category.reload.internal_category" do
      category.update_attribute(:color, "#000")
    end
  end
end
