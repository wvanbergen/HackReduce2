require 'rubygems'
require 'mandy'

Mandy.job "Calculate difference" do
  
  # 0        1            2    3                4                5               6                 7            8
  # exchange,stock_symbol,date,stock_price_open,stock_price_high,stock_price_low,stock_price_close,stock_volume,stock_price_adj_close
  # NASDAQ,DELL,1997-08-26,83.87,84.75,82.50,82.81,48736000,10.35
  map do |line|
    # p line, line.chomp
    values = line.chomp.split(',')
    if values.length == 9 && values[0] == 'NASDAQ'
      change = values[6].to_f - values[3].to_f
      emit(values[2], [values[1], values[7], change.to_s])
    end
  end
end