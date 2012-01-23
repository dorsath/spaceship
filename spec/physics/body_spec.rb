require 'physics'

module Physics

  describe Body do

    describe "#push" do

      subject { Body.new :mass => 10, :forces => M[[1],[2],[0]] }

      before do
        subject.push(2, 3, 1)
      end

      it "can be pushed along x axis" do
        subject.forces[0,0].should be_within(0.01).of(1.2)
      end

      it "can be pushed along y axis" do
        subject.forces[1,0].should be_within(0.01).of(2.3)
      end

      it "can be pushed along z axis" do
        subject.forces[2,0].should be_within(0.01).of(0.1)
      end

    end

  end

end
