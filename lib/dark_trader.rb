require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML5(URI.open("https://coinmarketcap.com/all/views/all/"))

cryptos = []

doc.css("tr.cmc-table-row").each do |iter|

  crypto_name = iter.at(".cmc-table__column-name--name").text.strip # if "".cmc-table__cell--sort-by__name" brings hidden elements (3 column merged...)
  crypto_code = iter.at(".cmc-table__cell--sort-by__symbol").content.strip
  crypto_value = iter.at(".cmc-table__cell--sort-by__price").content.strip
  
  print crypto_name
  print " "
  print crypto_code
  print " "
  print crypto_value
  puts""

end


#cmc-table__cell cmc-table__cell--sticky cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__name