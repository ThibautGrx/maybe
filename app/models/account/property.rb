# == Schema Information
#
# Table name: account_properties
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account::Property < ApplicationRecord
  include Accountable
end
