class CLIParser

	def self.parse

		# ruby fuzz [discover | test] url OPTIONS 
		if (ARGV[0] == 'discover')
			puts 'discovery'
		elsif (ARGV[0] == 'test')
			puts 'testdat'
		end

		# test URL
		testURL = ARGV[1]

		# Other options
			# part 1: --custom-auth --common-words
		ARGV[2..-1].each do|arg|
			puts "#{arg}"

			# split each option
			options(arg)

		end

	end


	def self.options(arg)

		if (arg.downcase == "--custom-auth=dvwa")
			puts "this needs to be authenticated for dvwa."
		elsif (arg.downcase == "--custom-auth=bodgeit")
			puts "this needs to be authenticated for bodgeit."
		elsif (arg.downcase.include? "--common-words")
			puts "custom-words..."
		end

	end

end