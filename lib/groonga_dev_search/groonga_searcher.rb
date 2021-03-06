# class GroongaDevSearch::GroongaSearcher
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

module GroongaDevSearch
  class GroongaSearcher
    attr_reader :snippet

    def search(database, words, options={})
      posts = database.posts
      selected_posts = select_posts(posts, words, options)

      @snippet = Groonga::Snippet.new(width: 100,
                                      default_open_tag: "<span class=\"keyword\">",
                                      default_close_tag: "</span>",
                                      html_escape: true,
                                      normalize: true)
      words.each do |word|
        @snippet.add_keyword(word)
      end

      order = options[:reverse] ? "ascending" : "descending"
      sorted_posts = selected_posts.sort([{
                                            :key => "_score",
                                            :order => order,
                                          }])

      sorted_posts
    end

    def similar_search_by_text(database, text)
      posts = database.posts
      similar_posts = posts.select do |record|
        record.content.similar_search(text)
      end
      sorted_similar_posts = similar_posts.sort([{
                                            :key => "_score",
                                            :order => "descending",
                                          }])
      sorted_similar_posts
    end

    private
    def select_posts(posts, words, options)
      selected_posts = posts.select do |record|
        conditions = []
        #if options[:author_id]
        #  conditions << (record.authors =~ options[:author_id])
        #end
        #if options[:orthography]
        #  conditions << (record.orthography._key == options[:orthography])
        #end
        #if options[:copyrighted]
        #  conditions << (record.copyrighted._key == options[:copyrighted])
        #end
        #if options[:ndc]
        #  conditions << (record.ndc =~ options[:ndc])
        #elsif options[:ndc3]
        #  conditions << (record.ndc3 =~ options[:ndc3])
        #elsif options[:ndc2]
        #  conditions << (record.ndc2 =~ options[:ndc2])
        #elsif options[:ndc1]
        #  conditions << (record.ndc1 =~ options[:ndc1])
        #end
        #if options[:age_group]
        #  conditions << (record.age_group._key == options[:age_group])
        #end
        #if options[:kids]
        #  conditions << (record.kids == options[:kids])
        #end
        unless words.empty?
          match_target = record.match_target do |match_record|
              (match_record.index('Terms.Posts_subject') * 10) |
              (match_record.index('Terms.Posts_body'))
          end
          full_text_search = words.collect {|word|
            (match_target =~ word) |
              (record.from =~ word)
          }.inject(&:&)
          conditions << full_text_search
        end
        conditions
      end
      selected_posts
    end
  end
end
