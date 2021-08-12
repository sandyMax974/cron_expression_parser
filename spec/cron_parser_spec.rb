require 'cron_parser.rb'

RSpec.describe ".cron_expression_parse" do
  output_minutes = "minute        "
  output_hour = "hour          "
  output_day = "day of month  "
  output_month = "month         "
  output_day_of_week = "day of week   "
  output_command = "command       /usr/bin/find\n"

  every_minutes = "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59\n" 
  every_hour = "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23\n"
  every_day = "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31\n"
  every_month = "1 2 3 4 5 6 7 8 9 10 11 12\n"
  all_week = "1 2 3 4 5 6 7\n"

  
  it "converts to readable format when no value is specified" do
    expect{cron_expression_parse("* * * * * /usr/bin/find")}.to output(output_minutes + every_minutes + output_hour + every_hour + output_day + every_day+ output_month + every_month + output_day_of_week + all_week + output_command).to_stdout
  end
  
  it "converts to readable format when inputing single values" do
    expect{cron_expression_parse("0 0 * 1 3 /usr/bin/find")}.to output(output_minutes + "0\n" + output_hour + "0\n" + output_day + every_day + output_month + "1\n" + output_day_of_week + "3\n" + output_command).to_stdout 
  end

  it "converts to readable format when incremental values are inputted" do
    expect{cron_expression_parse("*/15 */6 * 1/3 1-5 /usr/bin/find")}.to output(output_minutes + "0 15 30 45\n" + output_hour + "0 6 12 18\n" + output_day + every_day + output_month + "1 4 7 10\n" + output_day_of_week + "1 2 3 4 5\n"+ output_command).to_stdout 
  end

  it "converts to readable format when multiple values are inputted" do
    expect{cron_expression_parse("5,15 6,18 5 6,12 * /usr/bin/find")}.to output(output_minutes + "5 15\n" + output_hour + "6 18\n" + output_day + "5\n" + output_month + "6 12\n" + output_day_of_week + all_week + output_command).to_stdout 
  end

  it "converts to readable format when range values are inputted" do
    expect{cron_expression_parse("5-10 6-8 1,15 6-9 MON-FRI /usr/bin/find")}.to output(output_minutes + "5 6 7 8 9 10\n" + output_hour + "6 7 8\n" + output_day + "1 15\n" + output_month + "6 7 8 9\n" + output_day_of_week + "1 2 3 4 5\n" + output_command).to_stdout 
  end
end