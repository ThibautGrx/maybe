# == Schema Information
#
# Table name: account_cryptos
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account::Crypto < ApplicationRecord
  include Accountable
end
