Soon::Application.config.session_store :redis_store,
  servers: [
    {
      url: REDIS_URL,
      namespace: "session"
    }
  ],
  expire_after: 90.minutes,
  key: "_#{Rails.application.class.module_parent_name.downcase}_session",
  threadsafe: true,
  secure: Rails.env.production?
