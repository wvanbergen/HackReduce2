require 'spec_helper'

require 'nasdaq_difference'

describe 'nasdaq difference mapper' do
  
  before(:all) do
    job_name = "Calculate daily difference"
    @runner = Mandy::TestRunner.new(job_name)
  end
    
  it "should be map a normal line properly" do
    line = '{"exchange":"NASDAQ","stock_symbol":"DELL","date":"1997-08-26","stock_price_open":83.87,"stock_price_high":84.75,"stock_price_low":82.50,"stock_price_close":82.81,"stock_volume":48736000,"stock_price_adj_close":10.35},'
    @runner.map(line) do |mapper|
      mapper.should_receive(:emit).with("DELL", "1997-08-26", '48736000', '-1.06')
    end
  end
  
  it "should ingore a line that doesn't parse" do
    line = '{"docs":['
    @runner.map(line) do |mapper|
      mapper.should_not_receive(:emit)
    end
    
  end
end