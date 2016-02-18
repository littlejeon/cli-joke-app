require 'open-uri'
require 'nokogiri'
require 'pry'
def create_project_hash
  html = "http://www.punoftheday.com/cgi-bin/disppuns.pl?ord=F&cat=0&sub=0&page=1"

  puns = Nokogiri::HTML(html)
# binding.pry
  projects = {}
  puns.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i,
    }
  end
  projects
  array

end
#binding.pry
