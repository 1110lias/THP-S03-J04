require 'nokogiri'
require 'open-uri'

def perform
  doc = Nokogiri::HTML(URI.open("https://www.aude.fr/annuaire-mairies-du-departement/mairie-armissan"))
  puts "Please enter the URL of the city hall you're trying to contact (if you don't have any, please juste press enter):"
  print "> "
  townhall_url = gets.chomp
    if townhall_url.empty?
          townhall_url = "https://www.aude.fr/annuaire-mairies-du-departement/mairie-armissan"
          puts "ok, we're getting your the URL of mairie armissan: https://www.aude.fr/annuaire-mairies-du-departement/mairie-armissan"
    else
    end
    get_townhall_email(townhall_url)
    puts "now let's get all of them!:"
   result = get_townhall_url
   puts result
end

def get_townhall_email(townhall_url)
  doc = Nokogiri::HTML(URI.open(townhall_url))
  doc.css("p.infos__item.-email").each do |iter|
    the_mail = iter.at("a").text.strip
    puts the_mail
    return the_mail
  end
end

def get_townhall_url
    result = []
    base_url = "https://www.aude.fr"
    doc = Nokogiri::HTML(URI.open("https://www.aude.fr/annuaire-mairies-du-departement"))
    doc.css('a.directory-block__img-link.composite-link').each do |link|
      hash_temp = Hash.new
      relative_url = link['href']
      absolute_url = URI.join(base_url, relative_url).to_s
      temp_mail = get_townhall_email(absolute_url)
      hash_temp[absolute_url] = temp_mail
      result << hash_temp
    end
    return result
  end
  
perform
