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


end