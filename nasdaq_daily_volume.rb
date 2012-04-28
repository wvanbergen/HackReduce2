require 'rubygems'
require 'mandy'

Mandy.job "Calculate daily volume" do
  
  map do |date, value|
    symbol, volume, diff = value.split('|',3)
    emit(date, volume)
  end
  
  reduce do |date, volumes|
    emit(date, volumes.inject(0) { |sum, x| sum + x.to_i })
  end
end