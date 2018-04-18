base_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(base_dir, "lib")
$LOAD_PATH.unshift(lib_dir)
require "groonga_dev_search/web/app"

ENV["GROONGA_DEV_SEARCH_HOME"] ||= File.join(base_dir, ".groonga_dev_search")

if ENV["GROONGA_DEV_SEARCH_ENABLE_CACHE"]
  require "racknga"
  require "racknga/middleware/cache"

  cache_database_path = File.join(base_dir, "var", "cache", "db")
  use Racknga::Middleware::Cache, :database_path => cache_database_path
end

run GroongaDevSearch::Web::App
