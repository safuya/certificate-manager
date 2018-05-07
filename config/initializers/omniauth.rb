# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Strategies::LDAP,
  title: ENV['LDAP_TITLE'],
  host: ENV['LDAP_HOST'],
  port: 636,
  method: :tls,
  base: ENV['LDAP_BASE'],
  uid: ENV['LDAP_UID'],
  name_proc: proc { |name| name.gsub(/@.*$/, '') },
  bind_dn: ENV['LDAP_BIND_DN'],
  filter: ENV['LDAP_FILTER'],
  password: ENV['LDAP_PASSWORD']
