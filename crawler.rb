require 'mechanize'
require 'json'

class Crawler

	@@links = Array.new
	@@site = String.new

	def self.crawl(agent, filename)

		@@site = agent.page.uri
		puts "\nStarting Crawler on #{@@site} ..."
		
		# find all the link on initial page and crawl deeper
		pageLinks = agent.get(@@site).links.find_all { |link| @@links.push(link.href) } 
		@@links.uniq.each do |link| 
			crawldeep(agent, link)
		end
		puts JSON.pretty_generate(@@links.uniq) 

		puts "\nSearching site from given words."

		# if words file exist search site for it
		if File.exist?(filename)
			begin 
				f = File.new(filename) 
				while(line = f.readline)
					word = line.chomp
					searchSite(agent, word, @@site)
				end
			rescue EOFError
				f.close
			end
		end

		return @@links.uniq #retuns a list of all the unique links

	end

	# function for searching the site with the words provided
	def self.searchSite(agent, word, uri)
		begin
			links = agent.get(uri)
			# search the page with the word criteria
			links.links_with(:href => /.*?#{word}*/).each do |l|
				puts "\t#{l.href}"
				@@links.push(l.href)
			end
		rescue Mechanize::ResponseCodeError
			puts "Response Code Error Occured."
		end
	end

	# function for crawlling deeper from the initial links found
	def self.crawldeep(agent, link)
		begin
			pageLinks = agent.get(link).links.find_all 
			pageLinks.each do |l|
				unless(@@site == l.uri)
					@@links.push(l.href)
				end
			end
		rescue Mechanize::ResponseCodeError
			# puts "#{link} received an error."
		end
	end

end