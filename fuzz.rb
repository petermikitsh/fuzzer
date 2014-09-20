require_relative 'CLIParser'
require_relative 'Authentication'
require_relative 'Crawler'

class Fuzz

	def self.Main
		input = CLIParser.parse
		agent = Authentication.authenticate(input['custom-auth'])
		Crawler.crawl(agent)
	end

	Fuzz.Main

end
