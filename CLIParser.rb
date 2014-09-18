class CLIParser

	def self.parse
		#ruby fuzz [discover | test] url OPTIONS 
		if (ARGV[0] == 'discover')
			puts 'discovery'
		end
		if (ARGV[0] == 'test')
			puts 'testdat'
		end
		testURL = ARGV[1] #URL to test
		ARGV[2..-1].each do|arg|#Other options
			puts arg
		end
		#ARGV.each do|a| 
		#	puts "Argument: #{a}"
		#end 
	end

	parse
end