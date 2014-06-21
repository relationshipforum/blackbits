REDIS_URL = "redis://:herpityderpityderp!@cnmrelo.lyceed.com:6379/0/bb"
REDIS     = Redis.new(url: REDIS_URL)

Blackbits::Application.config.cache_store = :redis_store, REDIS_URL
Blackbits::Application.config.session_store :redis_store, redis_server: REDIS_URL
