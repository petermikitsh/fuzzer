class CLIParser

	def self.parse
		ARGV.each do|a| 
			puts "Argument: #{a}" 
		end 
	end

end
