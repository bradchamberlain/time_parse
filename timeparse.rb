require 'time'

DATES = {}

def as_time s
 s = s.split(/[\s,\/,:]/).map{ |s| s.to_i }
 Time.new s[2] + 2000, s[0], s[1], s[3], s[4]
end

File.foreach("data.txt") do |line|
	key = line.split(" ")[0]
	DATES[key] = Array.new unless DATES[key]
	DATES[key] << as_time(line.strip!)
end 

DATES.keys.each do |key|
	time_split = (DATES[key].length == 4 ? (DATES[key][1] - DATES[key][2])/60 : 0 )
	minutes = ((DATES[key].first - DATES[key].last) / 60) - time_split
	hours = (minutes/60).floor
	adjusted_minutes = (minutes - (hours * 60)).to_i
	puts "#{key} = #{hours} hours #{adjusted_minutes} minutes (#{time_split.floor} minute break)"
end
