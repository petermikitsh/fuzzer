# Test.rb
# 
# Description:  Implements replacive fuzzing by testing a set of URL's with 
#               attack vectors and determines if a vulnerabilty occured on
#               the target.
#
# Author: Peter Mikitsh pam3961
# Author: Akshay Karnawat

require 'mechanize'
require 'net/http'
require 'timeout'

class Test

	# urls: string array of absolute URL paths to test
	# vectors: string array of replacive vectors to append to urls
	# authAgent: optional 'Mechanize' agent (if authentication used

	def self.test(urls, vectors, authAgent, random, timeout)
		puts "Testing Vectors..."
		
		# create a new agent with timeout attributes
		agent = authAgent ? authAgent : Mechanize.new

		urls.each do |url|
			vectors.each do |vector|
				Test.replaciveFuzz(url, vector, agent, timeout)
			end
		end
	end

	def self.createAttackURL(url, vector)
		return url + vector;
	end

	def self.replaciveFuzz(url, vector, agent, timeout)
		begin
			puts "Testing #{vector} on #{url}"
		  	Timeout.timeout(5) { agent.get(Test.createAttackURL(url, vector)) }
		rescue Mechanize::ResponseCodeError => e
			puts "\t#{e.response_code} Unexcepted response code for url #{url} with vector #{vector}."
		rescue Timeout::Error
			puts "Timeout error for url #{url} with vector #{vector}."
		end
	end

end
