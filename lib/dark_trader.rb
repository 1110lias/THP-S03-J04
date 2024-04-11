require 'nokogiri'
require 'open-uri'

def perform
  doc = Nokogiri::HTML5(URI.open("https://coinmarketcap.com/all/views/all/"))
  cryptos = je_scrapping (doc)
  print cryptos
  puts ""
end

def je_scrapping (doc)
  begin
    cryptos = []
      doc.css(".cmc-table-row").each do |iter|
      crypto_info = Hash.new
      crypto_name = iter.at(".cmc-table__column-name--name").content.strip # if "".cmc-table__cell--sort-by__name" brings hidden elements (3 column merged...)
      crypto_code = iter.at(".cmc-table__cell--sort-by__symbol").content.strip
      crypto_value = iter.at(".cmc-table__cell--sort-by__price").content.strip
      puts  "Getting data for #{crypto_name}"
      sleep 0.2
      crypto_info[crypto_code] = crypto_value
      cryptos << crypto_info
      end
    rescue NoMethodError => e
        # puts "Scrapping finito"
    end
  return cryptos
end

perform