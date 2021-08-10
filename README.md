# Technical Task - Cron Expression Parser (Ruby)

**Status**: Incomplete
- The parser does not currently convert `day of month` and `day of week`.

# Description
Command line script which parses a cron string and expands each field to show the times at which it will run. 

We are only considering the standard cron format with five time fields (minute, hour, day of month, month, and day of week) plus a command, and are not need handling the special time strings such as "@yearly". The input will be on a single line.
The cron string is passed to your application as a single argument.

The output will be formatted as a table with the field name taking the first 14 columns and the times as a space-separated list following it. For example, the following input argument:
```
*/15 0 1,15 * 1-5 /usr/bin/find
```
Will yield the following output:
  
```
minute        0 15 30 45
hour          0
day of month  1 15
month         1 2 3 4 5 6 7 8 9 10 11 12
day of week   1 2 3 4 5
command       /usr/bin/find
```

## Requierements

### How to install
```
$ git clone git@github.com:sandyMax974/cron_expression_parser.git
$ cd cron_expression_parser
$ bundle install
```
### How to run
```
$ cd lib
$ ruby parser.rb "*/15 0 1,15 * 1-5 /usr/bin/find"
```
### How to test
```
$ cd cron_expression_parser
$ bundle exec rspec
```

## Next steps

- [ ] Implement code to parse `day of week`
- [ ] Implement code to parse `day of month`
- [ ] Refactor code to be DRY