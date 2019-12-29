require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/reunion'
require_relative '../lib/activity'

class ReunionTest < Minitest::Test

  def setup
    @reunion = Reunion.new("1406 BE")
    @activity_1 = Activity.new("Brunch")
    @activity_2 = Activity.new("Drinks")    
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

  def test_it_can_return_detailed_breakout
    skip
    @activity_1.add_participant("Maria", 20)
    @activity_1.add_participant("Luther", 40)
    @reunion.add_activity(@activity_1)
    @activity_2.add_participant("Maria", 60)
    @activity_2.add_participant("Luther", 60)
    @activity_2.add_participant("Louis", 0)
    @reunion.add_activity(@activity_2)
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

end

