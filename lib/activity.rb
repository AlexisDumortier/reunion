class Activity

  attr_reader :name, :participants, :total_cost

  def initialize  (name) 
    @name = name
    @participants = {}
    @total_cost = 0
  end 

  def add_participant(name, cost)
    @participants[name] = cost
    @total_cost += cost
  end

end