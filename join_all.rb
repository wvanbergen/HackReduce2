require 'rubygems'
require 'mandy'

TYPES  = %w{MSGS VOLUME DIFF}

Mandy.job "Join all" do
  map_tasks 5
  reduce_tasks 1
  
  map do |key, value|
    year_and_month, type = split_key(key)
    emit(year_and_month, [type, value])
  end
  
  reduce do |year_and_month, types_and_values|
    types_and_values = Hash[*types_and_values.join('|').first.split('|')]
    ordered_values = TYPES.map{ |type| types_and_values[type] }.compact
    emit(year_and_month, ordered_values)  if ordered_values.size == 3
  end
end

def split_key(key)
  year_and_month, type = key.split('|')
  type ||= 'MSGS'
  [year_and_month, type]
end

