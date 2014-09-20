require_relative 'CLIParser'
require_relative 'Authentication'

class Fuzz

	def self.Main
		input = CLIParser.parse
		puts input['custom-auth']
		Authentication.authenticate(input['custom-auth'])
	end

	Fuzz.Main

end
