def field_parser(cron_field, start, limit, mapping)

  if !mapping.nil?
    mapping.each_key do |day|
      if cron_field.include?(day.to_s)
        cron_field.gsub!(day.to_s, mapping[day].to_s)
      end
    end
  end

  if cron_field == "*"
    result = Array(start..limit)
    result.map! { |time| time.to_s }
  elsif cron_field == "0"
    result = ["0"]
  elsif cron_field.include?("/")
    if cron_field.split("/")[0] == "*"
      start_at = start
    else
      start_at = cron_field.split("/")[0].to_i
    end
    result = []
    repeat_every = cron_field.split("/")[1].to_i
    while start_at <= limit do
      result.push(start_at)
      start_at += repeat_every
    end
    result.map! { |time| time.to_s }
  elsif cron_field.include?(",")
    result = cron_field.split(",")
  elsif cron_field.include?("-")
    result = Array(cron_field.split("-")[0]..cron_field.split("-")[1])
  else
    result = [cron_field]
  end
end

LIMIT_VALUES = [59, 23, 31, 12, 7]
WEEKDAY = {
  "MON": 1, 
  "TUE": 2,
  "WED": 3,
  "THU": 4,
  "FRI": 5,
  "SAT": 6,
  "SUN": 7
}

def cron_expression_parse(cron_expression)
  cron_array = cron_expression.split(" ")

  minutes = field_parser(cron_array[0], 0, LIMIT_VALUES[0], nil)
  hour = field_parser(cron_array[1], 0, LIMIT_VALUES[1], nil)
  day_of_month = field_parser(cron_array[2], 1, LIMIT_VALUES[2], nil)
  months = field_parser(cron_array[3], 1, LIMIT_VALUES[3], nil)
  day_of_week = field_parser(cron_array[4], 1, LIMIT_VALUES[4], WEEKDAY)


  puts "minute        " + minutes.join(" ")
  puts "hour          " + hour.join(" ")
  puts "day of month  " + day_of_month.join(" ")
  puts "month         " + months.join(" ")
  puts "day of week   " + day_of_week.join(" ")
  puts "command       " + cron_array[5]
end


