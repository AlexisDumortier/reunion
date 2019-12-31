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
    list_of_participants.reduce({}) do |det_breakout, participant|
    @activities.each do |activity|
      if activity.owed[participant]
        amount = activity.owed[participant]
        activity_owed = activity.owed
        activity_owed.delete(participant)
        payees = activity_owed.reduce([]) do |acc, charge|
          amount > 0 ? (acc << charge[0] if charge[1] < 0) : (acc << charge[0] if charge[1] > 0)
          acc
        end
        if det_breakout[participant] 
          det_breakout[participant] << {activity: activity.name, payees: payees, amount: (amount/payees.size).to_i} 
        else
          det_breakout[participant] = [{activity: activity.name, payees: payees, amount: (amount/payees.size).to_i}]
        end
      end
    end
    det_breakout
    end
  end

  def list_of_participants
    list_participants = @activities.reduce([]) do |participants, activities|
      participants << activities.participants.to_a
      participants
    end
    (list_participants.flatten.select {|part| part.class == String}).uniq
  end
end