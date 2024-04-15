# == Schema Information
#
# Table name: account_other_assets
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account::OtherAsset < ApplicationRecord
  include Accountable
end
