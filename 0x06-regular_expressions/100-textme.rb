#!/usr/bin/env ruby
SENDER = ARGV[0].scan(/\[from:(.*)\] \[to/).join
RECEIVER = ARGV[0].scan(/\[to:(.*)\] \[flags/).join
FLAGS = ARGV[0].scan(/\[flags:(.*)\] \[msg/).join


puts SENDER + ',' + RECEIVER + ',' + FLAGS
