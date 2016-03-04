class Jury
  attr_accessor :members

  def initialize
    @members = Array.new
    @finalists = Hash.new
  end

  def announce_winner(final_votes)
    current_highest_vote_count = 0
    current_winner = nil

    final_votes.each do |key, value|
      if value > current_highest_vote_count
        current_highest_vote_count = value
        current_winner = key
      end
    end

    puts
    puts "The winner is #{current_winner.to_s.capitalize.green}!"
    return current_winner

  end

  def report_votes(final_votes)
    final_votes.each do |k, v|
      puts "#{k.to_s.capitalize.yellow} received #{v} votes."
    end
  end

  def cast_votes(finalists)
    finalists.each do |finalist|
      @finalists[finalist] = 0
    end

    @members.each do |member|
      random_finalist = @finalists.keys.sample
      puts "#{member.to_s.capitalize.yellow} cast their vote for #{random_finalist.to_s.capitalize.pink}."
      @finalists[random_finalist] += 1
    end

    return @finalists
  end

  def add_member(person)
    @members << person
  end
end
