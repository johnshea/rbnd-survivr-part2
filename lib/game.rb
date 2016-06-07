class Game
  attr_reader :tribes

  def initialize(*tribes)
    @tribes = tribes
  end

  def add_tribe(tribe)
    @tribes.push tribe
  end

  def immunity_challenge
    @tribes.sample
  end

  def clear_tribes
    @tribes.clear
  end

  def merge(merged_tribe_name)
    Tribe.new({name: merged_tribe_name, members: @tribes[0].members + @tribes[1].members})
  end

  def individual_immunity_challenge
    @tribes.sample.members.sample
  end
end
