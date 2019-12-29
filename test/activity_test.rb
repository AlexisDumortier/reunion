# pry(main)> activity.total_cost

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/activity'

class ActivityTest < Minitest::Test 

  def setup
    @activity = Activity.new("Brunch")
  end

  def test_it_exists
    assert_instance_of Activity, @activity 
  end

  def test_it_has_attributes
    assert_equal "Brunch", @activity.name
    assert_equal ({}), @activity.participants
    assert_equal 0, @activity.total_cost
  end

  def test_it_can_add_participants
    assert_equal ({}), @activity.participants
    @activity.add_participant("Maria", 20)
    assert_equal ({"Maria" => 20}), @activity.participants
  end

  def test_it_can_split_cost_evenly
    @activity.add_participant("Maria", 20)
    @activity.add_participant("Luther", 40)
    assert_equal 30, @activity.split
    @activity.add_participant("Mark", 60)
    assert_equal 40, @activity.split
  end

  def test_it_can_calculate_how_much_everyone_owes
    @activity.add_participant("Maria", 20)
    @activity.add_participant("Luther", 40)
    assert_equal ({"Maria" => 10, "Luther" => -10}), @activity.owed
  end
end