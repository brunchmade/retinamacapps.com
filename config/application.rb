config.middleware.use Rack::StaticCache, 
  urls: %w(
    /images
    /favicon.ico
  ),
  root: "public_cached"