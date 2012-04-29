require 'rubygems'
require 'mandy'


Mandy.job "nasdaq monthly volume" do
  map_tasks 5
  reduce_tasks 1
  
  map do |date, value|
    symbol, volume, diff = value.split('|',3)
    emit("#{date[0, 7]}|VOLUME", volume)
  end
  
  reduce do |month, volumes|
    emit(month, volumes.inject(0) { |sum, x| sum + x.to_i })
  end
end
