require 'rubygems'
require 'mandy'

Mandy.job "Calculate daily difference" do
  
  map do |date, value|
    symbol, volume, diff = value.split('|',3)
    emit(date, diff.to_f * volume.to_i)
  end
  
  reduce do |date, weighted_diffs|
    emit(date, weighted_diffs.inject(0) { |sum, x| sum + x.to_f })
  end
end