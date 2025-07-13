Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.font_src    :self, :https, :data, "https://fonts.gstatic.com"
  policy.img_src     :self, :https, :data
  policy.object_src  :none
  policy.script_src  :self, :https
  policy.style_src   :self, :https, "https://fonts.googleapis.com"
  # policy.connect_src :self, :https, "http://localhost:3035", "ws://localhost:3035"
end
