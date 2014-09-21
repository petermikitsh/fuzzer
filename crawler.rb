require 'mechanize'

class Crawler

	def self.crawl(agent)

		puts "Current URL: #{agent.page.uri}"

		puts "Starting Crawler..."

		page = agent.page.link.uri()
		all_links = agent.get(page).links.find_all

		all_links.each do |k|
			printf("\t%-30s %s\n", k, k.uri)
		end

		all_links
		
	end

end