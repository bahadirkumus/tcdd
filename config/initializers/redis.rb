REDIS_BASE_URL = ENV.fetch("REDIS_URL") { "redis://localhost:6379" }
REDIS_URL = "#{REDIS_BASE_URL}/0"
