# class GroongaDevSearch::Loader
#
# Copyright (C) 2018  Masafumi Yokoyama <yokoyama@clear-code.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

require "groonga_dev_search/groonga_database"

require "fileutils"
require "mail"

module GroongaDevSearch
  class Loader
    def load(options={})
      posts = []

      Dir.glob("#{DATA_DIR}/*") do |path|
        index_by_month = 0
        basename = File.basename(path, ".txt")
        File.open(path, "r:utf-8") do |file|
          text = ""
          file.each_line do |line|
            case line
            when /^From /
              if text.empty?
                next
              end
              mail = Mail.new(text.gsub(/\n/, "\r\n"))
              text = ""
              index_by_month += 1
              key = "#{basename}-#{"%04d" % index_by_month}"
              Groonga["Posts"].add(
                key,
                from: mail.from,
                date: mail.date.to_s,
                subject: mail.subject,
                body: mail.body.to_s.encode("UTF-8", mail.charset),
              )
            else
              text << line
            end
          end
        end
      end
    end
  end
end
