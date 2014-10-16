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

	# url: string of absolute URL paths to test
	# vectors: string array of replacive vectors to append to urls
	# authAgent: optional 'Mechanize' agent (if authentication used

	def self.test(urls, vectors, authAgent, random, timeout)
		puts "Testing Vectors..."
		
		# create a new agent with timeout attributes
		agent = authAgent ? authAgent : Mechanize.new

		urls.shift
		urls.each do |url|
			vectors.each do |vector|
				Test.replaciveFuzz(url, vector, agent, timeout)
			end
		end
	end

	def self.createAttackURL(url, vector)
		return url + "/" + vector;
	end

	def self.replaciveFuzz(url, vector, agent, timeout)
		begin
			attack_url = Test.createAttackURL(url, vector)
			puts "Testing URL #{attack_url}"
		  	Timeout.timeout(timeout) {
		  		response = agent.get(attack_url)
		  		if response.body.include? vector
			      puts "\t Possible vulnerability identified. The response body contains the attack vector."
		        end
		  	}
		rescue Mechanize::ResponseCodeError => e
			puts "\t Possible vulnerability identified. #{e.response_code} - Unexcepted response code."
		rescue Timeout::Error
			puts "\t Possible vulnerability identified. Timeout error."
		end
	end

end
