require 'physics'

module Physics
  describe World do

    context "with gravity and a stationary body" do

      let(:body) { Body.new(:mass => 10) }

      let(:position) { Position[0, 0, 0] }

      let(:world) { World.new(9.8, body => position) }

      subject {
        world.over(3).position_of(body)
      }

      it "recalculates position of an object at a next point in time" do
        subject.x.should be_within(0.01).of(0.0)
      end

      it "recalculates position of an object at a next point in time" do
        subject.y.should be_within(0.01).of(-44.1)
      end

      it "recalculates position of an object at a next point in time" do
        subject.z.should be_within(0.01).of(0.0)
      end

    end

    context "with gravity and a stationary body with several over calls" do

      let(:body) { Body.new(:mass => 10) }

      let(:position) { Position[0, 0, 0] }

      let(:world) { World.new(9.8, body => position) }

      subject {
        world.position_of(body)
      }

      it "recalculates position of an object at a next point in time" do
        subject.y.should be_within(0.01).of(0.0)

        world.over(1).position_of(body)
        subject.y.should be_within(0.01).of(-4.9)

        world.over(2).position_of(body)
        subject.y.should be_within(0.01).of(-44.1)
      end



    end
  end
end
