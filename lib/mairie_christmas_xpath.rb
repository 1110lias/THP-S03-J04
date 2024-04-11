require 'nokogiri'
require 'open-uri'
require 'pry'

doc = Nokogiri::HTML(URI.open("https://www.aude.fr/annuaire-mairies-du-departement"))

mairies_page = doc.xpath("//article[@class='directory-block__item']")

hash = {}

mairies_page.each do |block|
    ville = block.at("h2.directory-block__title").text
    mail = block.at("p.-email a").text
    hash[ville] = mail
end

hash.each do |ville, mail|
  puts "#{ville} => #{mail}"
end