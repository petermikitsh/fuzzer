class Authentication

	def self.authenticate(app)

		if (app.downcase == "dvwa")
			# authenticate via dvwa
		elsif (app.downcase == "bodgeit")
			# authenticate via bodgeit
		else
			puts "Authentication via #{app} is not allowed."
		end


	end

end
