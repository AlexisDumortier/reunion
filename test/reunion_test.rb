  require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/reunion'
require_relative '../lib/activity'

class ReunionTest < Minitest::Test

  def setup
    @reunion = Reunion.new("1406 BE")
    @activity_1 = Activity.new("Brunch")
    @activity_2 = Activity.new("Drinks")    
    @activity_3 = Activity.new("Bowling")
    @activity_4 = Activity.new("Jet Skiing")
  end

  def test_it_exists
    assert_instance_of Reunion, @reunion
  end 

  def test_it_has_attributes
    assert_equal "1406 BE", @reunion.name
    assert_equal [], @reunion.activities
  end 

  def test_it_can_add_activities
    assert_equal [], @reunion.activities
    @reunion.add_activity(@activity_1)
    assert_equal [@activity_1], @reunion.activities
  end 

  def test_it_can_calculate_the_total_cost
    @activity_1.add_participant("Maria", 20)
    @activity_1.add_participant("Luther", 40)
    @reunion.add_activity(@activity_1)
    assert_equal 60, @reunion.total_cost
    
    @activity_2.add_participant("Maria", 60)
    @activity_2.add_participant("Luther", 60)
    @activity_2.add_participant("Louis", 0)
    @reunion.add_activity(@activity_2)
    assert_equal 180, @reunion.total_cost
  end

  def test_it_can_calculate_the_breakout 
    @activity_1.add_participant("Maria", 20)
    @activity_1.add_participant("Luther", 40)
    @reunion.add_activity(@activity_1)
    @activity_2.add_participant("Maria", 60)
    @activity_2.add_participant("Luther", 60)
    @activity_2.add_participant("Louis", 0)
    @reunion.add_activity(@activity_2)
    assert_equal ({"Maria" => -10, "Luther" => -30, "Louis" => 40}), @reunion.breakout
  end
  
  def test_it_can_return_a_reunion_summary
    @activity_1.add_participant("Maria", 20)
    @activity_1.add_participant("Luther", 40)
    @reunion.add_activity(@activity_1)
    @activity_2.add_participant("Maria", 60)
    @activity_2.add_participant("Luther", 60)
    @activity_2.add_participant("Louis", 0)
    @reunion.add_activity(@activity_2)
    assert_equal "Maria: -10\nLuther: -30\nLouis: 40", @reunion.summary
  end

  def test_it_can_return_a_list_of_participants
    @activity_1.add_participant("Maria", 20)
    @activity_1.add_participant("Luther", 40)
    @reunion.add_activity(@activity_1)
    @activity_2.add_participant("Maria", 60)
    @activity_2.add_participant("Luther", 60)
    @activity_2.add_participant("Louis", 0)
    @reunion.add_activity(@activity_2)
    assert_equal ["Maria", "Luther", "Louis"], @reunion.list_of_participants
  end 

  def test_it_can_return_a_detailed_breakout
    @activity_1.add_participant("Maria", 20)
    @activity_1.add_participant("Luther", 40)
    @activity_2.add_participant("Maria", 60)
    @activity_2.add_participant("Luther", 60)
    @activity_2.add_participant("Louis", 0)
    @activity_3.add_participant("Maria", 0)
    @activity_3.add_participant("Luther", 0)
    @activity_3.add_participant("Louis", 30)
    @activity_4.add_participant("Maria", 0)
    @activity_4.add_participant("Luther", 0)
    @activity_4.add_participant("Louis", 40)
    @activity_4.add_participant("Nemo", 40)
    @reunion.add_activity(@activity_1)
    @reunion.add_activity(@activity_2)
    @reunion.add_activity(@activity_3)
    @reunion.add_activity(@activity_4)
    
    expected_output = {
    "Maria" => [
    {
      activity: "Brunch",
      payees: ["Luther"],
      amount: 10
    },
    {
      activity: "Drinks",
      payees: ["Louis"],
      amount: -20
    },
    {
      activity: "Bowling",
      payees: ["Louis"],
      amount: 10
    },
    {
      activity: "Jet Skiing",
      payees: ["Louis", "Nemo"],
      amount: 10
    }
    ],
    "Luther" => [
    {
      activity: "Brunch",
      payees: ["Maria"],
      amount: -10
    },
    {
      activity: "Drinks",
      payees: ["Louis"],
      amount: -20
    },
    {
      activity: "Bowling",
      payees: ["Louis"],
      amount: 10
    },
    {
      activity: "Jet Skiing",
      payees: ["Louis", "Nemo"],
      amount: 10
    }
    ],
    "Louis" => [
    {
      activity: "Drinks",
      payees: ["Maria", "Luther"],
      amount: 20
    },
    {
      activity: "Bowling",
      payees: ["Maria", "Luther"],
      amount: -10
    },
    {
      activity: "Jet Skiing",
      payees: ["Maria", "Luther"],
      amount: -10
    }
    ],
    "Nemo" => [
    {
      activity: "Jet Skiing",
      payees: ["Maria", "Luther"],
      amount: -10
    }
    ]
    }
    assert_equal expected_output, @reunion.detailed_breakout
  end

end

