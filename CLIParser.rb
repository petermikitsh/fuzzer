class CLIParser
	@@acceptedOptions = {"common-words" => "str", 
						 "vectors" => "str",
						 'sensitive' => 'str',
						 'random' => 'bool',
						 'slow' => 'int',
						 'url' => 'str',
						 'custom-auth' => 'str'}

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
				optionKey = optArray[0][2..-1]
				if @@acceptedOptions.include? optionKey
					case @@acceptedOptions[optionKey]
					when 'str'
						optionValue = optArray[1]
					when 'bool'
						optionValue = to_boolean(optArray[1])
					when 'int'
						#Need to test if optArray[1] is an int
						optionValue = optArray[1].to_i
					else
						puts 'Bad value for option ' + arg
						abort
					end
					options[optionKey] = optionValue
				else
					puts "Option #{optionKey} not supported"
					abort
				end
			end
		end
		puts options
		return options
	end

	#Converts ("true" | "false") into boolean values
	def self.to_boolean(str)
      if (str == 'true')
      	return true
      elsif (str == 'false')
      	return false
      else
      	puts "Non boolean value given for argument random"
      	abort
      end	
    end

	parse
end
