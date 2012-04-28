require 'spec_helper'

require 'nasdaq_difference'

describe 'nasdaq difference mapper' do
  
  before(:all) do
    job_name = "Calculate daily difference"
    @runner = Mandy::TestRunner.new(job_name)
  end
    
  it "should be map a normal line properly" do
    line = 'NASDAQ,DELL,1997-08-26,83.87,84.75,82.50,82.81,48736000,10.35'
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