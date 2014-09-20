class Authentication

	def self.authenticate(app)

		# authenticate via dvwa
		if (app.downcase == "dvwa")

			username = "admin"
			password = "password"
			url = "http://127.0.0.1/dvwa/login.php"

			# TODO - authenticate


		# authenticate via bodgeit
		elsif (app.downcase == "bodgeit")

			username = "none"
			password = "none"
			url = "http://127.0.0.1:8080/bodgeit"

			# TODO - authenticate
			
		else
			puts "Authentication via #{app} is not allowed."
		end


	end

end
