describe DailyScoreSpec do

  describe ".add" do
    context "given an empty string" do
      it "returns zero" do
        expect(DailyScoreSpec.add("")).to eql(0)
      end
    end
  end
end