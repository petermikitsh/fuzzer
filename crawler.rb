require 'mechanize'
require 'json'

class Crawler

	@@links = Array.new
	@@formInputs = Array.new
	@@site = String.new

	def self.crawl(agent, filename)

		@@site = agent.page.uri

		puts "\nStarting Crawler on #{@@site} ..."
		
		# find all the link on initial page and crawl deeper
		pageLinks = agent.get(@@site).links.find_all { |link| @@links.push(link.href) } 
		@@links.uniq.each do |link| 
			crawldeep(agent, link)
			forminputs(agent, link)
		end
		# print site links
		puts "Site Links"
		puts JSON.pretty_generate(@@links.uniq)

		# prints form inputs
		puts "\nForm Inputs"
		puts JSON.pretty_generate(@@formInputs.uniq)

		# if words file exist search site for it
		if(filename != nil) 
			puts "\nSearching site from given words."
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
		else
			# puts "No common-words file Specified."
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

	# crawl for form inputs
	def self.forminputs(agent,link)
		begin 
			pageForms = agent.get(@@site + link).forms
			pageForms.each do |f|
				@@formInputs.push("#{link} => " + "#{f.fields}")
			end
		rescue Mechanize::ResponseCodeError => e
			puts "\tError: #{e.response_code} => for form on page #{e.page.uri}"
		end
	end

end