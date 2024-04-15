# == Schema Information
#
# Table name: users
#
#  id                               :uuid             not null, primary key
#  email                            :string
#  first_name                       :string
#  last_alerted_upgrade_commit_sha  :string
#  last_login_at                    :datetime
#  last_name                        :string
#  last_prompted_upgrade_commit_sha :string
#  password_digest                  :string
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  family_id                        :uuid             not null
#
# Indexes
#
#  index_users_on_email      (email) UNIQUE
#  index_users_on_family_id  (family_id)
#
# Foreign Keys
#
#  fk_rails_...  (family_id => families.id)
#
class User < ApplicationRecord
  has_secure_password

  belongs_to :family
  accepts_nested_attributes_for :family

  validates :email, presence: true, uniqueness: true
  normalizes :email, with: ->(email) { email.strip.downcase }

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  def acknowledge_upgrade_prompt(commit_sha)
    update!(last_prompted_upgrade_commit_sha: commit_sha)
  end

  def acknowledge_upgrade_alert(commit_sha)
    update!(last_alerted_upgrade_commit_sha: commit_sha)
  end

  def has_seen_upgrade_prompt?(upgrade)
    last_prompted_upgrade_commit_sha == upgrade.commit_sha
  end

  def has_seen_upgrade_alert?(upgrade)
    last_alerted_upgrade_commit_sha == upgrade.commit_sha
  end
end
