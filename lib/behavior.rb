class Behavior

  attr_reader :subject

  def initialize(subject)
    @subject = subject
  end

  def handle_instructions(instructions)
    instructions.each do |instruction|
      send(instruction) if respond_to?(instruction)
    end
  end

  def handle
    raise NotImplementedError.new("implement in subclass")
  end

  def current_time
    Time.now.to_f * 100
  end

end
