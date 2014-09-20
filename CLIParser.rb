class CLIParser
	@@acceptedOptions = {"common-words" => "str", 
						 "vectors" => "str",
						 'sensitive' => 'str',
						 'random' => 'bool',
						 'slow' => 'int',
						 'url' => 'str',
						 'custom-auth' => 'str'}
	@@supportedCustomAuthentications = ["dvwa", "bodgeit"]
	def self.parse
		options = {}
		if ARGV.length < 2
			puts 'Wrong length.  Style is fuzz [discover | test] url OPTIONS'
			abort
		end
		#ruby fuzz [discover | test] url OPTIONS
		if (ARGV[0] != "discover") && (ARGV[0] !="test")
			puts "Bad command #{ARGV[0]}. Supported commands are discover and test"
			abort
		end
		options['command'] = ARGV[0]

		#Verify integrity of URL argument here
		options['url'] = ARGV[1]

		#OPTIONS are in the form --optionName=value
		ARGV[2..-1].each do|arg|#Other options
			optArray = Array.new
			optArray = arg.split('=')
			if optArray.length != 2
				puts 'Wrong length for option ' + arg
				abort
			elsif optArray[0][0..1] != '--'
				puts "Bad option formatting: no --s for option #{arg}"
				abort
			else
				optionKey = optArray[0][2..-1]
				if @@acceptedOptions.include? optionKey
					case @@acceptedOptions[optionKey]
					when 'str'
						optionValue = optArray[1]
						if optionKey == "custom-auth"
							if ! @@supportedCustomAuthentications.any?{|s| s.casecmp(optionValue) ==0}
								puts "System supports custom authentication for: #{@@supportedCustomAuthentications}"
								abort
							else
								optionValue.downcase!
							end
						end
					when 'bool'
						optionValue = to_boolean(optArray[1])
						if optionValue == nil
							puts "Bad boolean given for #{optionKey}"
							abort						
						end
					when 'int'
						if is_i(optArray[1])#Need to test if optArray[1] is an int
							optionValue = optArray[1].to_i
						else
							puts "Argument for #{optionKey} not an int"
							abort
						end
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
		return options
	end

	#Converts ("true" | "false") into boolean values
	def self.to_boolean(str)
      if (str == 'true')
      	return true
      elsif (str == 'false')
      	return false
      else
      	return nil
      end	
    end

    #Checks if str is a valid integer (ie only contains 0..9)
    def self.is_i(str)
    	x = /\d+/ =~ str
    	if x != nil
    		return true
    	else
    		return false
    	end
    end

    #Call self.parse for testing
	parse
end