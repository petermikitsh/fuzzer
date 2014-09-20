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

		arg.chomp

		if (arg.downcase.include? "--custom-auth")
			customAuth = arg.split('=')
			puts "#{customAuth[1]}"
		elsif (arg.downcase.include? "--common-words")
			wordFile = arg.split('=')
			puts "#{wordFile[1]}"
		end

	end

end