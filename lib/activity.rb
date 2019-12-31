class Activity

  attr_reader :name, :participants, :total_cost, :spending_per_person

  def initialize(name) 
    @name = name
    @participants = {}
    @total_cost = 0
  end 

  def add_participant(name, cost)
    @participants[name] = cost
    @total_cost += cost
  end

  def split
    @total_cost / @participants.size.to_f
  end

  def owed
    @participants.reduce({}) do |owed_per_person, participant|
      owed_per_person[participant[0]] = split - participant[1]
      owed_per_person
    end
  end

end