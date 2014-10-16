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

	# url: string array of absolute URL paths to test
	# vectors: string array of replacive vectors to append to urls
	# authAgent: optional 'Mechanize' agent (if authentication used

	def self.test(url, vectors, authAgent, random, timeout)
		puts "Testing Vectors..."
		
		# create a new agent with timeout attributes
		agent = authAgent ? authAgent : Mechanize.new

		vectors.each do |vector|
			Test.replaciveFuzz(url, vector, agent, timeout)
		end
	end

	def self.createAttackURL(url, vector)
		return url + vector;
	end

	def self.replaciveFuzz(url, vector, agent, timeout)
		begin
			puts "Testing #{vector} on #{url}"
		  	Timeout.timeout(timeout) { agent.get(Test.createAttackURL(url, vector)) }
		rescue Mechanize::ResponseCodeError => e
			puts "\t Possible vulnerability identified. #{e.response_code} Unexcepted response code for url #{url} with vector #{vector}."
		rescue Timeout::Error
			puts "\t Possible vulnerability identified. Timeout error for url #{url} with vector #{vector}."
		end

		if agent.body.include? vector
			puts "\t Possible vulnerability identified. The response body contains the attack vector. Vector: #{vector} Url: #{url}"
		end
	end

end
