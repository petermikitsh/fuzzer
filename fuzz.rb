require_relative 'CLIParser'
require_relative 'Authentication'

class Fuzz

	def self.Parse()
		CLIParser.parse
	end


	def self.Auth()
		Authentication.authenticate
	end

	Fuzz.Parse
	Fuzz.Auth

end
