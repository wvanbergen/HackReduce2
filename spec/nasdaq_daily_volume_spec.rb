require 'spec_helper'

require 'nasdaq_daily_volume'

describe 'nasdaq difference' do
  
  before(:all) do
    job_name = "Calculate daily volume"
    @runner = Mandy::TestRunner.new(job_name)
  end
    
  it "should map a normal line properly" do
    line = "1997-08-26\tDELL|30000|0.4"
    @runner.map(line) do |mapper|
      mapper.should_receive(:emit).with("1997-08-26", "30000")
    end
  end
  
  it "should reduce properly" do
    @runner.reduce("1997-08-26" => ['1', '2', '3']) do |mapper|
      mapper.should_receive(:emit).with("1997-08-26", 6)
    end
  end  
end