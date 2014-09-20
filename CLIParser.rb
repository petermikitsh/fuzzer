class CLIParser
	@@acceptedOptions = ['command', 'url', 'common-words', 'vectors', 'sensitive', 'random', 'slow', 'url', 'custom-auth']
	def self.parse
		options = {}
		if ARGV.length <= 2
			puts 'Wrong length.  Style is fuzz [discover | test] url OPTIONS'
			abort
		end
		#ruby fuzz [discover | test] url OPTIONS
		options['command'] = ARGV[0]
		options['url'] = ARGV[1]

		#OPTIONS are in the form --optionName=value
		ARGV[2..-1].each do|arg|#Other options
			optArray = Array.new
			optArray = arg.split('=')
			if optArray.length != 2
				puts 'Wrong length of for option ' + arg
				abort
			elsif optArray[0][0..1] != '--'
				puts 'Bad option formatting: no --s for option ' + arg
				abort
			else
				strOption = optArray[0][2..-1]
				if @@acceptedOptions.include? strOption
					options[strOption] = optArray[1]
				else
					puts "Option #{strOption} not supported"
					abort
				end
			end
		end
		puts options
		return options
	end
	parse
end
