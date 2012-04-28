require 'spec_helper'

require 'join_all'

describe "Join all" do

  before(:all) do
    job_name = "Join all"
    @runner = Mandy::TestRunner.new(job_name)
  end

  it "mapper when type defined" do
    sample_line = "2010-08|VOLUME\t12233"
    @runner.map(sample_line) do |mapper|
      mapper.should_receive(:emit).with('2010-08', ["VOLUME", "12233"])
    end
  end

  it "mapper when type undefined" do
    sample_line = "2010-08\t12233"
    @runner.map(sample_line) do |mapper|
      mapper.should_receive(:emit).with('2010-08', ["MSGS", "12233"])
    end
  end

  it "reducer should not emit when it receives less than 3 values" do 
    @runner.reduce("1997-08" => 'MSGS|200|VOLUME|3000') do |reducer|
      reducer.should_receive(:emit).never
    end
  end

  it "reducer should emit when in the proper order " do 
    @runner.reduce("1997-08" => 'DIFF|-10|MSGS|200|VOLUME|3000') do |reducer|
      reducer.should_receive(:emit).with("1997-08", %w{ 200 3000 -10 })
    end
  end
end
