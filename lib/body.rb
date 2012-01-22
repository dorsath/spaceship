class Body
  def initialize
    @instructions = Set.new
    @abilities = []
    if defined? ABILITIES
      @abilities = ABILITIES.map { |ab| ab.new(self) }
    end
  end

  def draw
    @abilities.each do |ability|
      ability.handle_instructions(@instructions)
      ability.handle
    end
    @instructions.clear
  end

  def to(action)
    @instructions << action
    self
  end
  alias_method :and, :to
end
