# == Schema Information
#
# Table name: account_credits
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account::Credit < ApplicationRecord
  include Accountable
end
