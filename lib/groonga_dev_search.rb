require "groonga_dev_search/version"
require "groonga_dev_search/groonga_database"
require "groonga_dev_search/groonga_searcher"
require "groonga_dev_search/crawler"
require "groonga_dev_search/loader"
require "groonga_dev_search/command"

module GroongaDevSearch
  HOST_NAME = "http://osdn.jp/"
  BASE_PATH = "projects/groonga/lists/archive/dev/"

  YEARS = [
    "2009",
    "2010",
    "2011",
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
  ]

  MONTHS = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ]

  DATA_DIR = "data"
  DB_DIR = "db"
end
