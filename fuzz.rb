require_relative 'CLIParser'
require_relative 'Authentication'
require_relative 'crawler'

class Fuzz

	def self.Main
		input = CLIParser.parse
		if (ARGV[0] == "discover")
			agent = Authentication.authenticate(input['custom-auth'])
			crawl = Crawler.crawl(agent, input['common-words'])
		elsif (ARGV[0] !="test")
			test = Test.test(input['url'], input['vectors'])#, nil)
		end
	end

	Fuzz.Main

end
