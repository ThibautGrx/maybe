# Dynamic settings the user can change within the app (helpful for self-hosting)
# == Schema Information
#
# Table name: settings
#
#  id         :bigint           not null, primary key
#  value      :text
#  var        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_settings_on_var  (var) UNIQUE
#
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  field :render_deploy_hook,
        type: :string,
        default: ENV["RENDER_DEPLOY_HOOK"],
        validates: { allow_blank: true, format: { with: /\Ahttps:\/\/api\.render\.com\/deploy\/srv-.+\z/ } }

  field :upgrades_mode,
        type: :string,
        default: ENV.fetch("UPGRADES_MODE", "manual"),
        validates: { inclusion: { in: %w[manual auto] } }

  field :upgrades_target,
        type: :string,
        default: ENV.fetch("UPGRADES_TARGET", "release"),
        validates: { inclusion: { in: %w[release commit] } }
end
