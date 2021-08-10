
def cron_expression_parse(cron_expression)
  cron_array = cron_expression.split(" ")

  if cron_array[0] == "*"
    minutes = Array(0..59)
    minutes.map! { |time| time.to_s }
  elsif cron_array[0] == "0"
    minutes = ["0"]
  elsif cron_array[0].include?("/")
    if cron_array[0].split("/")[0] == "*"
      start_at = 0
    else
      start_at = cron_array[0].split("/")[0].to_i
    end
    minutes = []
    repeat_every = cron_array[0].split("/")[1].to_i
    while start_at <= 59 do
      minutes.push(start_at)
      start_at += repeat_every
    end
    minutes.map! { |time| time.to_s }
  elsif cron_array[0].include?(",")
    minutes = cron_array[0].split(",")
  elsif cron_array[0].include?("-")
    minutes = Array(cron_array[0].split("-")[0]..cron_array[0].split("-")[1])
  else
    minutes = [cron_array[0]]
  end

  if cron_array[1] == "*"
    hour = Array(0..23)
    hour.map! { |time| time.to_s }
  elsif cron_array[1] == "0"
    hour = ["0"]
  elsif cron_array[1].include?("/")
    if cron_array[1].split("/")[0] == "*"
      start_at = 0
    else
      start_at = cron_array[1].split("/")[0].to_i
    end
    hour = []
    repeat_every = cron_array[1].split("/")[1].to_i
    while start_at <= 23 do
      hour.push(start_at)
      start_at += repeat_every
    end
    hour.map! { |time| time.to_s }
  elsif cron_array[1].include?(",")
    hour = cron_array[1].split(",")
  elsif cron_array[1].include?("-")
    hour = Array(cron_array[1].split("-")[0]..cron_array[1].split("-")[1])
  else
    hour = [cron_array[1]]
  end

  if cron_array[3] == "*"
    months = Array(1..12)
    months.map! { |month| month.to_s }
  elsif cron_array[3].include?("/")
    start_at = cron_array[3].split("/")[0].to_i
    repeat_every = cron_array[3].split("/")[1].to_i
    months = []
    while start_at <= 12 do
      months.push(start_at)
      start_at += repeat_every
    end
    months.map! { |month| month.to_s }
  elsif cron_array[3].include?(",")
    months = cron_array[3].split(",")
  elsif cron_array[3].include?("-")
    months = Array(cron_array[3].split("-")[0]..cron_array[3].split("-")[1])
  else
    months = [cron_array[3]]
  end


  puts "minute        " + minutes.join(" ")
  puts "hour          " + hour.join(" ")
  puts "day of month  "
  puts "month         " + months.join(" ")
  puts "day of week   "
  puts "command       " + cron_array[5]
end