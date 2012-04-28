require 'spec_helper'

job_name = 'nasdaq_monthly_difference'
require job_name

describe job_name do
  
  before(:all) do
    @runner = Mandy::TestRunner.new(job_name)
  end
    
  it "should map a normal line properly" do
    line = "1997-08-26\tDELL|30000|0.4"
    @runner.map(line) do |mapper|
      mapper.should_receive(:emit).with("1997-08|DIFF", 12000.0)
    end
  end
  
  it "should reduce properly" do
    @runner.reduce("1997-08|DIFF" => ['1', '2', '3']) do |reducer|
      reducer.should_receive(:emit).with("1997-08|DIFF", 6)
    end
  end  
end
