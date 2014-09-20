require_relative 'CLIParser'
require_relative 'Authentication'

class Fuzz

	def self.Parse()
		CLIParser.parse
	end

	#  @args => custom app to authenticate against
	def self.Auth(app)
		Authentication.authenticate(app)
	end

	Fuzz.Parse
	app = "dvwa";
	Fuzz.Auth(app)

end
