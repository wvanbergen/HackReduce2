require 'spec_helper'

require 'nasdaq_difference'

describe 'nasdaq difference' do
  
  before(:all) do
    job_name = "Calculate difference"
    @runner = Mandy::TestRunner.new(job_name)
  end
    
  it "should be map a normal line properly" do
    line = "NASDAQ,DELL,1997-08-26,83.87,84.75,82.50,82.81,48736000,10.35\n"
    @runner.map(line) do |mapper|
      mapper.should_receive(:emit).with("1997-08-26", ["DELL", '48736000', '-1.06'])
    end
  end
  
  it "should ignore the header line" do
    line = "exchange,stock_symbol,date,stock_price_open,stock_price_high,stock_price_low,stock_price_close,stock_volume,stock_price_adj_close\n"
    @runner.map(line) do |mapper|
      mapper.should_not_receive(:emit)
    end
  end
  
  it "should ingore a line that doesn't parse" do
    line = '{"docs":['
    @runner.map(line) do |mapper|
      mapper.should_not_receive(:emit)
    end
  end
end