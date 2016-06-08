class Tribe
  attr_reader :name, :members

  def initialize(options)
    @name = options[:name]
    @members = options[:members]
    puts "Tribe #{@name.green} created."
  end

  def to_s
    @name
  end

  def tribal_council(options={})
    @immune = options[:immune]
    array_of_not_immune_members = @members.reject { |member| member == @immune}
    eliminated_member = array_of_not_immune_members.sample
    @members.delete eliminated_member
    return eliminated_member
  end
end
