# == Schema Information
#
# Table name: account_loans
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account::Loan < ApplicationRecord
  include Accountable
end
