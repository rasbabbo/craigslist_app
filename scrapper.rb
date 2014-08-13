# scrapper.rb
require 'nokogiri'
require 'open-uri'
require 'awesome_print'

# pushresults into an array
# pass array into date search
# pass filtered dates through the row search
#   map over to keep the original array




def filter_links(rows)
  dogs = rows.select do |row|
    row.css(".hrdlnk").text.match("/pup|puppy|puppies|dog/")
  end
end
  # takes in rows and returns uses
  # regex to only return links 
  # that have "pup", "puppy", or "dog"
  # keywords

def get_todays_rows(doc, date_str)

  rows = doc.css(".row")

  currentDate = rows.select do |row|
    row.css("span.date").text == date_str
  end
  filter_links(currentDate)
end


#   #  1.) open chrome console to look in inside p.row to see
#   #  if there is some internal date related content
#   #  2.) figure out the class that you'll need to select the
#   #   date from a row

def get_page_results(date_str)
  url = open("today.html")
  doc = Nokogiri::HTML(url)
  get_todays_rows(doc, date_str)
end



def search(date_str)
  # go through the results returning only those with the dates;
  # get_page_result
  results = get_page_results(date_str)
  rows = results.map do |result| {
     title: result.css(".hrdlnk").text
    }
  end
  rows
end








# want to learn more about 
# Time in ruby??
#   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#strftime-method
today = Time.now.strftime("%b %d")
results = search(today)
puts results

