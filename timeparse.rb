require 'time'

DATES = {}

def as_time s
 s = s.split(/[\s,\/,:]/).map{ |s| s.to_i }
 Time.new s[2] + 2000, s[0], s[1], s[3], s[4]
end

def calculate_minutes start_time, end_time
	(end_time - start_time)/60
end

def break_time val
	val > 0 ? "(#{val.floor} minute break)" : ""
end


File.foreach("data.txt") do |line|
	key = line.split(" ")[0]
	DATES[key] = Array.new unless DATES[key]
	DATES[key] << as_time(line.strip!)
end 

DATES.each do |k, value|
	time_split = (value.length == 4 ? calculate_minutes(value[2], value[1]) : 0 )
	minutes = calculate_minutes(value.last, value.first) - time_split
	hours = (minutes/60).floor
	adjusted_minutes = (minutes - (hours * 60)).to_i
	puts "#{k} = #{hours} hours #{adjusted_minutes} minutes #{break_time time_split}"
end
