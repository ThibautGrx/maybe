# == Schema Information
#
# Table name: account_vehicles
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account::Vehicle < ApplicationRecord
  include Accountable
end
