def cron_expression_parse(cron_expression)
  cron_array = cron_expression.split(" ")

  if cron_array[0] == "*"
    minutes = Array(0..59)
    minutes.map! { |time| time.to_s }
  elsif cron_array[0] == "0"
    minutes = ["0"]
  elsif cron_array[0].include?("/")
    cron_array[0].split("/") # could be removed
    if cron_array[0].split("/")[0] == "*"
      start_at = 0
      repeat_every = cron_array[0].split("/")[1].to_i # duplication
    else
      start_at = cron_array[0].split("/")[0].to_i
      repeat_every = cron_array[0].split("/")[1].to_i # duplication
    end
    minutes = []
    # repeat_every = cron_array[0].split("/")[1].to_i
    while start_at <= 59 do
      minutes.push(start_at)
      start_at += repeat_every
    end
    minutes.map! { |time| time.to_s }
  elsif cron_array[0].include?(",")
    minutes = [] # no need
    minutes = cron_array[0].split(",")
    minutes
  elsif cron_array[0].include?("-")
    minutes = Array(cron_array[0].split("-")[0]..cron_array[0].split("-")[1])
  end

  if cron_array[1] == "*"
    hour = Array(0..23)
    hour.map! { |time| time.to_s }
  elsif cron_array[1] == "0"
    hour = ["0"]
  elsif cron_array[1].include?("/")
    cron_array[1].split("/")
    if cron_array[1].split("/")[0] == "*"
      start_at = 0
      repeat_every = cron_array[1].split("/")[1].to_i
    else
      start_at = cron_array[1].split("/")[0].to_i
      repeat_every = cron_array[1].split("/")[1].to_i
    end
    hour = []
    while start_at <= 23 do
      hour.push(start_at)
      start_at += repeat_every
    end
    hour.map! { |time| time.to_s }
  elsif cron_array[1].include?(",")
    # hour = []
    hour = cron_array[1].split(",")
    hour
  elsif cron_array[1].include?("-")
    hour = Array(cron_array[1].split("-")[0]..cron_array[1].split("-")[1])
  end

  if cron_array[3] == "*"
    months = Array(1..12)
    months.map! { |month| month.to_s }
  elsif cron_array[3].include?("/")
    # cron_array[3].split("/")
    start_at = cron_array[3].split("/")[0].to_i
    repeat_every = cron_array[3].split("/")[1].to_i
    months = []
    while start_at <= 12 do
      months.push(start_at)
      start_at += repeat_every
    end
    months.map! { |month| month.to_s }
  elsif cron_array[3].include?(",")
    months = []
    months = cron_array[3].split(",")
    months
  elsif cron_array[3].include?("-")
    months = Array(cron_array[3].split("-")[0]..cron_array[3].split("-")[1])
  end

  if cron_array[2] == "?"
    day_of_month = ["Any"]
  # elsif cron_array[2] == "*"
  #   day_of_month = Array(1..31)
  #   day_of_month.map! { |day| day.to_s }
  elsif cron_array[2].include?(",")
    day_of_month = cron_array[2].split(",")
  elsif cron_array[2].include?("-")
    day_of_month = Array(cron_array[2].split("-")[0]..cron_array[2].split("-")[1])
  end


  
  puts "minute        " + minutes.join(" ")
  puts "hour          " + hour.join(" ")
  puts "day of month  " + day_of_month.join(" ")
  puts "month         " + months.join(" ")
  puts "day of week   "
end

cron_statement = ARGV[0]
cron_expression_parse(cron_statement)