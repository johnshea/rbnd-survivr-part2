class Jury
  attr_accessor :members

  def initialize
    @members = Array.new
  end

  def announce_winner(final_votes)
    current_highest_vote_count = 0
    winner = final_votes.max_by { |k, v| v }.flatten[0]
    puts
    puts "The winner is #{winner.to_s.capitalize.green}!"
    return winner

  end

  def report_votes(final_votes)
    final_votes.each do |contestant, votes|
      puts "#{contestant.to_s.capitalize.yellow} received #{votes} votes."
    end
  end

  def cast_votes(finalists)
    finalists_votes = Hash.new

    finalists.each do |finalist|
      finalists_votes[finalist] = 0
    end

    @members.each do |member|
      random_finalist = finalists_votes.keys.sample
      puts "#{member.to_s.capitalize.yellow} cast their vote for #{random_finalist.to_s.capitalize.pink}."
      finalists_votes[random_finalist] += 1
    end

    return finalists_votes
  end

  def add_member(person)
    @members << person
  end
end
