# == Schema Information
#
# Table name: account_other_liabilities
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account::OtherLiability < ApplicationRecord
  include Accountable
end
