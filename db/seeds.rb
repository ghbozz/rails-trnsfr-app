require 'nokogiri'
require 'open-uri'
require 'json'

Transfert.destroy_all

def scraper(n)
  count = 1
  results = Hash.new
  n.times do
    url = "https://www.transfermarkt.fr/transfers/neuestetransfers/statistik?ajax=yw1&land_id=0&page=#{count}"
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    puts "========== Page #{count} ============"

    html_doc.search('.items > tbody > tr').each do |element|
      create_transfert(element)
    end
    count += 1
  end
end

def create_transfert(element)
  img = element.children[1].at('img').values.first
  name = element.at('.spielprofil_tooltip').text
  age = element.children[2].text
  nation = element.children[3].children.first.values[1]
  value = element.children[6].children.text
  clubs = set_clubs(element)


  if Club.find_by_name(clubs[0])
    from = Club.find_by_name(clubs[0])
  else
    from = Club.create(name: clubs[0][0], image: clubs[0][1])
  end

  if Club.find_by_name(clubs[1])
    to = Club.find_by_name(clubs[1])
  else
    to = Club.create(name: clubs[1][0], image: clubs[1][1])
  end

  if Player.find_by_name(name)
    player = Player.find_by_name(name)
  else
    player = Player.create!(name: name, age: age, nation: nation, image: img, club: to)
  end

  if !Transfert.where(player_name: name, from: clubs[0], to: clubs[1]).exists?
    Transfert.create(
     from: from.name,
     to: to.name,
     value: convert_value(value),
     player: player
    )
  end
end

def convert_value(value)
  value == '?' ? 'N/A' : value
end

def set_clubs(element)
  from = nil
  to = nil

  if element.children[4].at('.vereinprofil_tooltip') != nil
    from = element.children[4].at('.vereinprofil_tooltip').children.first.values[2]
    from_img = element.children[4].at('.vereinprofil_tooltip').at('.tiny_wappen').values[0]
  else
    from = 'Sans club'
  end

  if element.children[5].at('.vereinprofil_tooltip') != nil
    to = element.children[5].at('.vereinprofil_tooltip').children.first.values[2]
    to_img = element.children[5].at('.vereinprofil_tooltip').at('.tiny_wappen').values[0]
  end

  return [[from, from_img], [to, to_img]]
end

scraper(1)
