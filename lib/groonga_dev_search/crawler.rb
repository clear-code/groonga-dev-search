#!/usr/bin/env ruby

require "fileutils"
require "net/https"
require "uri"

module GroongaDevSearch
  class Crawler
    def crawl(options={})
      FileUtils.mkdir_p(DATA_DIR)

      YEARS.product(MONTHS) do |pair|
        year, month = *pair
        basename = "#{year}-#{month}.txt"
        output_path = File.join(DATA_DIR, basename)
        if File.exist?(output_path)
          $stderr.puts("#{basename} already exists.")
          next
        end

        uri = URI.parse("#{HOST_NAME}#{BASE_PATH}#{basename}")
        res = nil
        5.times do
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = (uri.scheme == 'https')
          res = http.start do |h|
            h.get(uri.request_uri)
          end

          case res
          when Net::HTTPSuccess
            break
          when Net::HTTPRedirection
            uri = URI.parse(res["Location"])
            next
          else
            break
          end
        end
        sleep 3
        unless res.is_a?(Net::HTTPSuccess)
          $stderr.puts("#{basename} is not found.")
          next
        end

        File.open(output_path, "w") do |input_file|
          euc_text = res.body
          input_file.write(euc_text.encode("UTF-8", "EUC-JP"))
        end
      end
    end
  end
end
