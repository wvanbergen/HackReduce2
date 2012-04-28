require File.join(File.dirname(__FILE__), '../message_count')

describe "Word Count Solution" do
  before(:all) do
    @runner = Mandy::TestRunner.new("Msg Count")
  end

   describe "mapper" do
    it "splits on commas and emits date column" do
      sample_line = "3600042915,10,SYSTEM_CANNED,2008-08,c14a788acafd3d68a8b72acff8a64236,INBOX,0,APPROVED,9b022d4f34f969c4679d83d6173beec5,SENT,0,2008-08,3600042915,0"
      @runner.map(sample_line) do |mapper|
        mapper.should_receive(:emit).with('2008-08', 1)
      end
    end

    it "ignore empty date" do
      sample_line = "3600042915,10,SYSTEM_CANNED,2008-08,c14a788acafd3d68a8b72acff8a64236,INBOX,0,APPROVED,9b022d4f34f969c4679d83d6173beec5,SENT,0,,3600042915,0"
      @runner.map(sample_line) do |mapper|
        mapper.should_not_receive(:emit).with('2008-08', 1)
      end
    end

    it "ignore malformed data" do
      sample_line = ",,,w,"
      @runner.map(sample_line) do |mapper|
        mapper.should_not_receive(:emit).with('2008-08', 1)
      end
    end
  end

  describe "reducer" do
    it "counts occurrences" do
      occurrences = [1,1,1,1]
      @runner.reduce('2008-08' => occurrences) do |reducer|
        reducer.should_receive(:emit).with('2008-08', 4)
      end
    end
  end
end