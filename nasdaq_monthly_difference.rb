require 'rubygems'
require 'mandy'

Mandy.job "nasdaq_monthly_difference" do
  map_tasks 5
  reduce_tasks 1
  
  map do |date, value|
    symbol, volume, diff = value.split('|',3)
    emit("#{date[0, 7]}|DIFF", diff.to_f * volume.to_i)
  end
  
  reduce do |month, weighted_diffs|
    emit(month, weighted_diffs.inject(0) { |sum, x| sum + x.to_f })
  end
end
