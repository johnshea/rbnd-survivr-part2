class Tribe
  attr_reader :name, :members

  def initialize(options)
    @name = options[:name]
    @members = options[:members]
    puts "Tribe #{@name} created."
  end

  def to_s
    @name
  end

  def tribal_council(options)
    @immune = options[:immune]
    @members.each_with_index do |member, index|
      if member != @immune
        return @members.delete_at(index)
      end
    end
  end
end
