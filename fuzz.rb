require_relative 'CLIParser'
require_relative 'Authentication'
require_relative 'crawler'
require_relative 'test'

class Fuzz

	def self.Main
		input = CLIParser.parse
		if (ARGV[0] == "discover")
			agent = Authentication.authenticate(input['custom-auth'])
			crawl = Crawler.crawl(agent, input['common-words'])
		elsif (ARGV[0] == "test")
			agent = Authentication.authenticate(input['custom-auth'])
			crawl = Crawler.crawl(agent, input['common-words'])
			test = Test.test(ARGV[1], crawl, input['vectors'], nil, input['random'], input['slow'])
		end
	end

	Fuzz.Main

end
