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
    merged_members = @tribes[0].members + @tribes[1].members
    clear_tribes
    add_tribe(Tribe.new({name: merged_tribe_name, members: merged_members}))
    return @tribes.first
  end

  def individual_immunity_challenge
    @tribes.sample.members.sample
  end
end
