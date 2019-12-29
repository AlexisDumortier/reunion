class Reunion

  attr_reader :name, :activities

  def initialize(name) 
    @name = name 
    @activities = []
  end 

  def add_activity(activity)
    @activities << activity
  end

  def total_cost
    @activities.sum {|activity| activity.total_cost}
  end

  def breakout
    @activities.reduce(Hash.new(0)) do |breakout, activity|
      activity.owed.each do |participant| 
        breakout[participant[0]] += participant[1]
      end
      breakout
    end 
  end

  def summary
    breakout.reduce("") do |output, participant|
      output += (participant[0] + ": " + participant[1].to_i.to_s + "\n")
      output
    end.chomp
  end

  def detailed_breakout
    skip
  end

  def list_of_participants
    participants = @activities.reduce([]) do |participants, activities|
      participants << activities.participants.to_a
      participants
    end
    (participants.flatten.select {|part| part.class == String}).uniq
  end

end