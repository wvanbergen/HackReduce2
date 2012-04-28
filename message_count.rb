require "rubygems"
require "mandy"
require "csv"

Mandy.job "Msg Count" do
  map_tasks 5
  reduce_tasks 3

  map do |line|
    # 0 - id,
    # 1 - message_id
    # 2 - message_type
    # 3 - read_time - 2008-08
    # 4 - recipient_id
    # 5 - recipient_mailbox
    # 6 - recipient_star_flag
    # 7 - review_flag
    # 8 - sender_id
    # 9 - sender_mailbox
    #10 - sender_star_flag
    #11 - sent_time - 2008-08
    #12 - thread_id
    #13 - parent_id

    columns = line.split(",")
    next if columns[11].nil?
    emit(columns[11], 1)
  end

  reduce do |date, occurrences|
    emit(date, occurrences.size)
  end
end