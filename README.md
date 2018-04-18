# groonga-dev-search

The full-text search system for [groonga-dev](https://lists.osdn.me/mailman/listinfo/groonga-dev) by [Groonga](http://groonga.org/ja/).

## Usage

### Prepare

    $ git clone https://github.com/myokoym/groonga_dev_search
    $ bundle install

### Crawl mails

    $ bundle exec ruby -I lib bin/groonga_dev_search crawl

### Load data

    $ bundle exec ruby -I lib bin/groonga_dev_search load

### Search (for test)

    $ bundle exec ruby -I lib bin/groonga_dev_search search WORD

### Run web server

    $ bundle exec ruby -I lib bin/groonga_dev_search start

## License

* LGPL 2.1 or later. See LICENSE.txt for details.
