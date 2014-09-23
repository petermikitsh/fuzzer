require_relative 'CLIParser'
require_relative 'Authentication'
require_relative 'Crawler'

class Fuzz

	def self.Main
		input = CLIParser.parse
		agent = Authentication.authenticate(input['custom-auth'])
		crawl = Crawler.crawl(agent, input['common-words'])
		
	end

	Fuzz.Main

end
