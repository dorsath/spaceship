require 'physics'

describe Body do

  subject { Body.new(:mass => 10, :x_velocity => 1, :y_velocity => 2, :z_velocity => 0) }

  before do
    subject.push(2, 3, 1)
  end

  it "can be pushed along x axis" do
    subject.x_velocity.should be_within(0.01).of(1.2)
  end

  it "can be pushed along y axis" do
    subject.y_velocity.should be_within(0.01).of(2.3)
  end

  it "can be pushed along z axis" do
    subject.z_velocity.should be_within(0.01).of(0.1)
  end

end

describe World do

  context "in a world without gravity" do

    let(:body) { Body.new(:mass => 10, :x_velocity => 1, :y_velocity => 2, :z_velocity => 0) }

    let(:position) { Position[0, 0, 0] }

    let(:world) { World.new(0, body => position) }

    subject { world.over(3).position_of body }

    it "recalculates position of an object at a next point in time" do
      subject.x.should be_within(0.01).of(3.0)
    end

    it "recalculates position of an object at a next point in time" do
      subject.y.should be_within(0.01).of(6.0)
    end

    it "recalculates position of an object at a next point in time" do
      subject.z.should be_within(0.01).of(0.0)
    end

  end

  context "with gravity and a stationary body" do

    let(:body) { Body.new(:mass => 10) }

    let(:position) { Position[0, 0, 0] }

    let(:world) { World.new(9.8, body => position) }

    subject { world.over(3).position_of(body) }

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

end
