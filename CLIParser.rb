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
		options['slow'] = 0.5
		#puts ARGV.inspect
		if ARGV.length < 2
			puts 'Wrong length.  Style is fuzz [discover | test] url OPTIONS'
			abort
		end
		#ruby fuzz [discover | test] url OPTIONS
		if (ARGV[0] != "discover") && (ARGV[0] !="test")
			puts "Bad command #{ARGV[0]}. Supported commands are discover and test"
			abort
		end

		#add url to options
		options['url'] = ARGV[1]

		#OPTIONS are in the form --optionName=value
		ARGV[2..-1].each do|arg|#Other options
			optArray = Array.new
			optArray = arg.split('=')
			if optArray.length != 2
				puts 'Wrong length for option ' + arg
				abort
			elsif arg[0..1] != '--'
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
						if optionKey == 'vectors'
							if File.exists?(optionValue)
								words = Array.new
								begin 
									f = File.new(optionValue) 
									while(line = f.readline)
										if line != "\n"
											word = line.chomp
											words.push(word)
										end
									end
								rescue EOFError
									f.close
								end
								optionValue = words
							else
								puts 'File #{optionValue} not found.'
								abort
							end
						end
						if optionKey == 'sensitive'
							if File.exists?(optionValue)
								words = Array.new
								begin 
									f = File.new(optionValue) 
									while(line = f.readline)
										if line != "\n"
											word = line.chomp
											words.push(word)
										end	
									end
								rescue EOFError
									f.close
								end
								optionValue = words
							else
								puts 'File #{optionValue} not found.'
								abort
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
							optionValue = optionValue / 1000.0 #convert milliseconds -> seconds
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
	#	puts options
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
	#parse
end
