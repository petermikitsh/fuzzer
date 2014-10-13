# Test.rb
# 
# Description:  Implements replacive fuzzing by testing a set of URL's with 
#               attack vectors and determines if a vulnerabilty occured on
#               the target.
#
# Author: Peter Mikitsh pam3961

require 'mechanize'

class Test

	# urls: string array of absolute URL paths to test
	# vectors: string array of replacive vectors to append to urls
	# authAgent: optional 'Mechanize' agent (if authentication used

	def self.test(urls, vectors, authAgent)
		agent = authAgent ? authAgent : Mechanize.new
		urls.each do |url|
			vectors.each do |vector|
				Test.replaciveFuzz(url, vector, agent)
			end
		end
	end

	def self.createAttackURL(url, vector)
		return url + vector;
	end

	def self.replaciveFuzz(url, vector, agent)
		begin
		  agent.get(Test.createAttackURL(url, vector))
		rescue Mechanize::ResponseCodeError
			puts "Unexcepted response code."
		end
	end

end
