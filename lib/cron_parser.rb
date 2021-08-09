def cron_expression_parse(cron_expression)
  # <minute> <hour> <day-of-month> <month> <day-of-week>
  # */15 0 1,15 * 1-5
  cron_array = cron_expression.split(" ")
  
# hour and minutes use the same code - refactor into one method

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
  elsif cron_array[1] == "0"
    hour = ["0"]
  elsif cron_array[0].include?("/")
    cron_array[1].split("/")
    if cron_array[0].split("/")[1] == "*"
      start_at = 0
      repeat_every = cron_array[1].split("/")[1].to_i
    else
      start_at = cron_array[1].split("/")[0].to_i
      repeat_every = cron_array[1].split("/")[1].to_i
    end
    hour = []
    while start_at <= 23 do
      hour.push(start_at)
      start_at+= repeat_every
    end
    hour.map! { |time| time.to_s }
  elsif cron_array[1].include?(",")
    hour = []
    hour = cron_array[1].split(",")
    hour
  elsif cron_array[1].include?("-")
    hour = Array(cron_array[1].split("-")[0]..cron_array[1].split("-")[1])
  end
end