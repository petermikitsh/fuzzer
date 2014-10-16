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

	# baseUrl: the baseUrl argument passed in from the command line
	# urls: array of string of absolute URL paths to test
	# vectors: string array of replacive vectors to append to urls
	# authAgent: optional 'Mechanize' agent (if authentication used

	def self.test(baseUrl, urls, vectors, authAgent, random, timeout)
		puts "Testing Vectors..."
		
		# create a new agent with timeout attributes
		agent = authAgent ? authAgent : Mechanize.new
		urls.shift
		urls.each do |url|
			vectors.each do |vector|
				Test.replaciveFuzz(baseUrl + url, vector, agent, timeout)
			end
		end
	end

	def self.createAttackURL(url, vector)
		return url + vector;
	end

	def self.replaciveFuzz(url, vector, agent, timeout)
		begin
			attack_url = Test.createAttackURL(url, vector)
			
		  	Timeout.timeout(timeout) {
		  		response = agent.get(attack_url)
		  		if response.body.include? vector
		  		  Test.printVulnerabilityFound(attack_url)
			      puts "\t The response body contains the attack vector."
		        end
		  	}
		rescue Mechanize::ResponseCodeError => e
			if e.response_code != "404"
				Test.printVulnerabilityFound(attack_url)
				puts "\t Possible vulnerability identified. #{e.response_code} - Unexcepted response code."
			end
		rescue Timeout::Error
			Test.printVulnerabilityFound(attack_url)
			puts "\t Possible vulnerability identified. Timeout error."
		end
	end

	def self.printVulnerabilityFound(attack_url)
		puts "Possible vulnerability identified: URL #{attack_url}"
	end

end
