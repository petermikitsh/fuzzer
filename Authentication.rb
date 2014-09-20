require 'net/http'
require 'mechanize'

class Authentication

	def self.authenticate(app)

		auth = {
			"dvwa" => {
				"username" => "admin",
				"password" => "password",
				"url" => "http://127.0.0.1/dvwa/login.php"
			},
			"bodgeit" => {
				"username" => "none",
				"password" => "none",
				"url" => "http://127.0.0.1:8080/bodgeit"
			}
		}

		agent = Mechanize.new
		webapp = app.downcase
		credentials = auth[webapp]

		# authenticate via dvwa / bodgeit
		if (["dvwa", "bodgeit"].include? webapp)

			puts "Generating POST Request to #{webapp}..."

			begin
				agent.post(auth[webapp]["url"], {
					"username" => auth[webapp]["username"],
					"password" => auth[webapp]["password"],
					"Login" =>  "Login"
				})
			rescue Mechanize::ResponseCodeError
				puts "Could not authenticate to #{webapp}."
			else
				# auth was successful
				puts "Authenticated to #{webapp}."
			end

		else
			puts "Authentication via #{app} is not allowed."
		end


	end

end
