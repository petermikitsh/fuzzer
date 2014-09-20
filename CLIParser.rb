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

			# split each option
			options(arg)

		end

	end


	def self.options(arg)

		opt = arg.split('=')

		if (opt[0].downcase.include? "--custom-auth")
			puts "#{opt[0]}  #{opt[1]}"
		elsif (opt[0].downcase.include? "--common-words")
			puts "#{opt[0]}  #{opt[1]}"
		end

	end

end