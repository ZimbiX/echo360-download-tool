#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'tmpdir'
require 'pathname'
require 'uri'

def valid_uri? url
  uri = URI.parse(url)
  uri.kind_of?(URI::HTTP)
rescue URI::InvalidURIError
  false
end

class LinkList
  attr_accessor :export_html_file_path

  def initialize rss_url = nil
    builder = Nokogiri::HTML::Builder.new do |doc|
      doc.html {
        doc.body {
          doc.ul {}
        }
      }
    end
    @doc = builder.doc
    @list = @doc.at_css 'ul'
    load_from_rss_url rss_url if rss_url
  end

  def add_link title, url
    # Element.new params: name, document to share GC lifecycle with
    li = Nokogiri::XML::Element.new 'li', @doc
    a = Nokogiri::XML::Element.new 'a', @doc
    a.content = title
    a[:href] = url
    li << a
    @list << li
  end

  def load_from_rss rss_content
    rss = Nokogiri::XML rss_content
    items = rss.css 'item'
    items.each do |item|
      title = item.at_css('title').content
      url = item.at_css('enclosure')[:url]
      add_link title, url
    end
  end

  def load_from_rss_url rss_url
    rss_content = open rss_url
    load_from_rss rss_content
  end

  def to_html
    @doc.to_html
  end

  def to_s
    @list.css('a').each do |a|
      title = a.content
      url = a[:href]
      puts "#{title}, #{url}"
    end
  end

  def save_to_file
    temp_file = Pathname.new(Dir.tmpdir) + 'echo360-links.htm'
    @export_html_file_path ||= temp_file
    File.open(@export_html_file_path, 'w') { |f| f.write to_html }
    puts "Exported to: #{@export_html_file_path}"
  end

  def save_and_open_in_firefox
    save_to_file
    puts "Opening in Firefox..."
    `firefox #{@export_html_file_path}`
  end
end

if __FILE__ == $0
  title = <<-END
Echo360 Downloader
==================

END
  help = <<-END
Usage: ruby echo360-download-tool.rb RSS_URL

A small program intended to help download video recordings of university lectures from Echo360. See the Readme file for more details.
END
  puts title
  if ARGV.length > 0 && ARGV.first != "--help"
    if valid_uri? ARGV.first
      list = LinkList.new ARGV.first
      puts list.to_s
      list.save_and_open_in_firefox
    else
      at_exit { puts '', help }
      abort "Error: You supplied an invalid URL"
    end
  else
    puts help
  end
end