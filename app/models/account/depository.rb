# == Schema Information
#
# Table name: account_depositories
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account::Depository < ApplicationRecord
  include Accountable
end
