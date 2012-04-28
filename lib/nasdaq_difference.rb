require 'rubygems'
require 'bundler/setup'

require 'mandy'
require 'json'
require 'date'

Mandy.job "Calculate daily difference" do
  
  # {"exchange":"NASDAQ",
  # "stock_symbol":"DELL",
  # "date":"1997-08-26",
  # "stock_price_open":83.87,
  # "stock_price_high":84.75,
  # "stock_price_low":82.50,
  # "stock_price_close":82.81,
  # "stock_volume":48736000,
  # "stock_price_adj_close":10.35},
  
  map do |line|
    begin
      values = JSON.parse(line[0 .. -2])
      change = values['stock_price_close'] - values['stock_price_open']
      emit(values['stock_symbol'], values['date'], values['stock_volume'].to_s, change.to_s)    
    rescue JSON::ParserError => e
      # noop
    end
  end
end