require_relative "game"
require_relative "tribe"
require_relative "contestant"
require_relative "jury"
require "colorizr"

#After your tests pass, uncomment this code below
#=========================================================
# Create an array of twenty hopefuls to compete on the island of Borneo
@contestants = %w(carlos walter aparna trinh diego juliana poornima juha sofia julia fernando dena orit colt zhalisa farrin muhammed ari rasha gauri)
@contestants.map!{ |contestant| Contestant.new(contestant) }.shuffle!

# Create two new tribes with names
@coyopa = Tribe.new(name: "Pagong", members: @contestants.shift(10))
@hunapu = Tribe.new(name: "Tagi", members: @contestants.shift(10))

# Create a new game of Survivor
@borneo = Game.new(@coyopa, @hunapu)
#=========================================================

NUM_ELIMINATIONS_IN_PHASE_ONE = 8
NUM_ELIMINATIONS_IN_PHASE_TWO = 3
NUM_ELIMINATIONS_IN_PHASE_THREE = 7

#This is where you will write your code for the three phases
def phase_one

  NUM_ELIMINATIONS_IN_PHASE_ONE.times do

    tribe_without_immunity = @borneo.immunity_challenge

    puts "Tribe #{tribe_without_immunity.to_s.green} lost the immunity challenge so they are voting someone off tonight."

    voted_off_contestant = tribe_without_immunity.tribal_council
    puts "#{voted_off_contestant.to_s.capitalize.red} was voted off the island."
    puts

  end
end

def phase_two

  NUM_ELIMINATIONS_IN_PHASE_TWO.times do
    immune_contestant = nil
    voted_off_contestant = nil

    immune_contestant = @borneo.individual_immunity_challenge
    puts "#{immune_contestant.to_s.capitalize.yellow} won the individual immunity challenge and is safe from elimination."
    voted_off_contestant = @merge_tribe.tribal_council({immune: immune_contestant})
    puts "#{voted_off_contestant.to_s.capitalize.red} was voted off the island."
    puts

  end
end

def display_remaining_tribe_members(tribe)
  tribe.members.each_with_index do |member, i|
    name = member.name.capitalize.pink
    print name + ', ' if i < tribe.members.length - 1
    puts name if i == tribe.members.length - 1
  end
end

def phase_three

  NUM_ELIMINATIONS_IN_PHASE_THREE.times do |i|
    immune_contestant = @borneo.individual_immunity_challenge
    voted_off_contestant = @merge_tribe.tribal_council({immune: immune_contestant})

    puts "#{voted_off_contestant.to_s.capitalize.red} was voted off the island and is member #{i+1} of the jury."
    @jury.add_member voted_off_contestant

    print "Remaining tribemates on #{"Cello".green} are: "
    display_remaining_tribe_members @merge_tribe

    puts
  end

end


# If all the tests pass, the code below should run the entire simulation!!
#=========================================================
phase_one #8 eliminations
@merge_tribe = @borneo.merge("Cello") # After 8 eliminations, merge the two tribes together
phase_two #3 more eliminations
@jury = Jury.new
phase_three #7 elminiations become jury members
finalists = @merge_tribe.members #set finalists
vote_results = @jury.cast_votes(finalists) #Jury members report votes
@jury.report_votes(vote_results) #Jury announces their votes
@jury.announce_winner(vote_results) #Jury announces final winner
