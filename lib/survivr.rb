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


#This is where you will write your code for the three phases
def phase_one
  number_of_eliminations = 0
  # puts
  # puts "Phase One"
  8.times do

    tribe_without_immunity = nil
    immune_contestant = nil
    voted_off_contestant = nil

    tribes = @borneo.tribes

    tribe_with_immunity = @borneo.immunity_challenge

    if tribe_with_immunity == tribes[0]
      tribe_without_immunity = tribes[1]
    else
      tribe_without_immunity = tribes[0]
    end

    puts "Tribe #{tribe_with_immunity.to_s.green} has won the immunity challenge so Tribe #{tribe_without_immunity.to_s.green} is voting someone off tonight."

    # puts "(START) Immune tribe: #{tribe_with_immunity.members.length}"
    # puts "(START) Voted off tribe: #{tribe_without_immunity.members.length}"

    immune_contestant = tribe_without_immunity.members.sample
    voted_off_contestant = tribe_without_immunity.tribal_council({immune: immune_contestant})
    puts "#{voted_off_contestant.to_s.capitalize.red} was voted off the island."
    puts

    # puts "(END) Immune tribe: #{tribe_with_immunity.members.length}"
    # puts "(END) Voted off tribe: #{tribe_without_immunity.members.length}"
    @borneo.clear_tribes
    @borneo.add_tribe tribe_with_immunity
    @borneo.add_tribe tribe_without_immunity
    number_of_eliminations += 1

  end

  # tribes = @borneo.tribes
  # puts "Survivors: #{tribes[0].members.length} #{tribes[0].members}"
  # puts "Survivors: #{tribes[1].members.length} #{tribes[1].members}"
  number_of_eliminations
end

def phase_two
  # phase_one
  # @merge_tribe = @borneo.merge("Cello")
  # puts
  # puts "Phase Two *************************************************"
  # puts "Merged tribe size: #{@merge_tribe.members.length}"

  number_of_eliminations = 0

  3.times do
    immune_contestant = nil
    voted_off_contestant = nil

    # immune_contestant = @merge_tribe.members.sample
    # voted_off_contestant = @merge_tribe.tribal_council({immune: immune_contestant})

    immune_contestant = @borneo.individual_immunity_challenge
    puts "#{immune_contestant.to_s.capitalize.yellow} won the individual immunity challenge and is safe from elimination."
    voted_off_contestant = @merge_tribe.tribal_council({immune: immune_contestant})
    puts "#{voted_off_contestant.to_s.capitalize.red} was voted off the island."
    puts

    number_of_eliminations += 1
  end
  # puts "Merged tribe size: #{@merge_tribe.members.length} left"
  number_of_eliminations
end

def phase_three
  # puts
  # puts "Phase Three *************************************************"
  # puts "Merged tribe size: #{@merge_tribe.members.length}"

  7.times do |i|
    immune_contestant = @merge_tribe.members.sample
    voted_off_contestant = @merge_tribe.tribal_council({immune: immune_contestant})
    puts "#{voted_off_contestant.to_s.capitalize.red} was voted off the island."
    @jury.add_member voted_off_contestant
    print "Remaining tribemates on #{"Cello".green} are: "
    @merge_tribe.members.each_with_index do |member, i|
      if i == @merge_tribe.members.length - 1
        puts member.name.capitalize.pink
      else
        print member.name.capitalize.pink + ', '
      end
    end
    puts "#{voted_off_contestant.to_s.capitalize.yellow} is member #{i+1} of the jury."
    puts

  end
  # puts "Jury is: #{@jury.members}"
  @jury.members.length
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
