require 'cron_parser.rb'

RSpec.describe "cron_expression_parse" do
  output_minutes = "minute        "
  output_hour = "hour          "
  output_day = "day of month  \n"
  output_month = "month         "
  output_day_of_week = "day of week   \n"

  every_minutes = "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59\n" 
  every_hour = "0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23\n"
  every_month = "1 2 3 4 5 6 7 8 9 10 11 12\n"

  it "converts CRON minutes fields to human readable format" do
    expect{cron_expression_parse("* * ? * * ")}.to output(output_minutes + every_minutes + output_hour + every_hour + output_day + output_month + every_month + output_day_of_week).to_stdout
  end
    it "converts CRON minutes fields to human readable format" do
    expect{cron_expression_parse("0 * ? * * ")}.to output(output_minutes + "0\n" + output_hour + every_hour + output_day + output_month + every_month + output_day_of_week).to_stdout 
  end
  it "converts CRON minutes fields to human readable format" do
    expect{cron_expression_parse("*/15 * ? * * ")}.to output(output_minutes + "0 15 30 45\n" + output_hour + every_hour + output_day + output_month + every_month + output_day_of_week).to_stdout 
  end
  it "converts CRON minutes fields to human readable format" do
    expect{cron_expression_parse("5/15 * ? * * ")}.to output(output_minutes + "5 20 35 50\n" + output_hour + every_hour + output_day + output_month + every_month + output_day_of_week).to_stdout 
  end
  it "converts CRON minutes fields to human readable format" do
    expect{cron_expression_parse("5,15 * ? * * ")}.to output(output_minutes + "5 15\n" + output_hour + every_hour + output_day + output_month + every_month + output_day_of_week).to_stdout 
  end
  it "converts CRON minutes fields to human readable format" do
    expect{cron_expression_parse("5-10 * ? * * ")}.to output(output_minutes + "5 6 7 8 9 10\n" + output_hour + every_hour + output_day + output_month + every_month + output_day_of_week).to_stdout 
  end

  it "converts CRON hours fields to human readable format" do
    
    expect{cron_expression_parse("* * ? * * ")}.to output(output_minutes + every_minutes + output_hour + every_hour + output_day + output_month + every_month + output_day_of_week).to_stdout
    expect{cron_expression_parse("0 0 ? * * ")}.to output(output_minutes + "0\n" + output_hour + "0\n" + output_day + output_month + every_month + output_day_of_week).to_stdout 
    expect{cron_expression_parse("0 2 ? * * ")}.to output(output_minutes + "0\n" + output_hour + "2\n" + output_day + output_month + every_month + output_day_of_week).to_stdout 
    expect{cron_expression_parse("0 0/6 ? * * ")}.to output(output_minutes + "0\n" + output_hour + "0 6 12 18\n" + output_day + output_month + every_month + output_day_of_week).to_stdout 
    expect{cron_expression_parse("0 0,6 ? * * ")}.to output(output_minutes + "0\n" + output_hour + "0,6\n" + output_day + output_month + every_month + output_day_of_week).to_stdout 
    expect{cron_expression_parse("0 0-6 ? * * ")}.to output(output_minutes + "0\n" + output_hour + "0 1 2 3 4 5 6\n" + output_day + output_month + every_month + output_day_of_week).to_stdout 
  end
end