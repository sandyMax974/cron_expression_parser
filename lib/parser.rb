require_relative 'cron_parser.rb'

cron_statement = ARGV[0]
cron_expression_parse(cron_statement)