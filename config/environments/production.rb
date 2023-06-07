require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials (and other encrypted files).
  # config.require_master_key = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Compress CSS using a preprocessor.
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Mount Action Cable outside main process or domain.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = "wss://example.com/cable"
  # config.action_cable.allowed_request_origins = [ "http://example.com", /http:\/\/example.*/ ]

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Include generic and useful information about system operation, but avoid logging too much
  # information to avoid inadvertent exposure of personally identifiable information (PII).
  config.log_level = :info

  # Prepend all log lines with the following tags.
  config.log_tags = [:request_id]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "gptfront_production"

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require "syslog/logger"
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new "app-name")

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  config.saml = OneLogin::RubySaml::Settings.new.tap do |settings|
    settings.assertion_consumer_service_url = 'https://ai-chat.respect.work/acs'
    settings.assertion_consumer_service_binding = 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST'
    settings.sp_entity_id = 'https://ai-chat.respect.work/'
    settings.idp_entity_id = 'http://vpn-gw.respect.work/adfs/services/trust'
    settings.idp_sso_service_url = 'https://vpn-gw.respect.work/adfs/ls/'
    settings.idp_sso_service_binding = 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST'
    settings.name_identifier_format = 'urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified'
    settings.idp_cert = <<-IDP_CERT
      -----BEGIN CERTIFICATE-----
      MIIC4jCCAcqgAwIBAgIQHsinPPgEh6tKZAonqimc/jANBgkqhkiG9w0BAQsFADAtMSswKQYDVQQDEy
      JBREZTIFNpZ25pbmcgLSB2cG4tZ3cucmVzcGVjdC53b3JrMB4XDTIyMTAyMzAxMjI0MVoXDTIzMTAy
      MzAxMjI0MVowLTErMCkGA1UEAxMiQURGUyBTaWduaW5nIC0gdnBuLWd3LnJlc3BlY3Qud29yazCCAS
      IwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKtAXQ1KrMRGk33seqkqqq6C0UyCsi3dxtrMVkVP
      nL5dgv+myiD3S3SOOC7CkPq/qJtX5izBdw8iwwjj/usVW/WTFill1bx49cbKhEPeWP660/NROCrFfw
      lYRJnL3A5lis4ErroBrs/jSKOyH8qzkgt567Gi0G9I/nGxu+VjRAzYXO8vRMF/P3uOb2g3/YZFlHaz
      HWdWypgq38q5Th4QTMs2U7GGRb0297uQs7WDe2KPe+R0nWwPIZTg6OScvtCZJVc+4OO0KWvGFcV7fH
      6DXsnh8QdtekuGZ5UiSw4d+aekfM8eCeumxW7whLAZw+0AjZhIRFlbOB8v9wiOaonUWWUCAwEAATAN
      BgkqhkiG9w0BAQsFAAOCAQEAkXdkkEslHBTkRcEWAWDD3ihUA/51vne+55PKmasRTcixE8vbkUktDs
      sgpjTp9IZ6N89Rt9ACbkD6vLa4TW2HDbCArC07yFpuJzNHXp1EJWn0a3LI0IVQDFX8xpddp/V1TxNv
      WDr4CQFC4bjlDAxCZ1FbOWPY87TZLgFtIQpju5kAg0FIOjAMVi6L3q1JqxGqktR+Vj3CUa7i8+wsKb
      RGZlDe/5qR2kiicPy61K7fLoudLPQAZd/OkAS6sZWZwUyyW+82oPK1u5VOMiHaVGK7qGIufHGaJ6kn
      T+NztHFL2KtHqG7U/xunfGO1lxoaGro7fk3rwpE6xMtmagBr43yLHA==
      -----END CERTIFICATE-----
    IDP_CERT
  end

end
