require 'highline/import'
require 'awesome_print'

class LogicProblem1
  attr_reader :the_set

  def initialize
    @families = {:t => "Trents", :w => "Williamses", :y => "Yandells"}
    @buildings = {:m => :mill, :f => :forge, :g => :granary, :i => :inn, :s => :stable}
  end
  
  def go
    @the_set = {}
    [:t, :w, :y].each do |family|
      resp = ask "in a comma separated list, write the first letter of each property owned by the #{@families[family]}"
      hsh = {:mill => false, :forge => false, :granary => false, :inn => false, :stable => false}
      resp.downcase.gsub(" ", "").split(",").each do |bldg|
        hsh[@buildings[bldg.to_sym]] = true
      end
      @the_set[family] = hsh
      ap @the_set
    end
    test_rule_one
    test_rule_one_point_five
    test_rule_two
    test_rule_three
  end
  
  
  def test_rule_one
    if @the_set[:w].select{|k,v| v == true}.count > @the_set[:y].select{|k,v| v == true}.count
      puts "passed test one"
      true
    else
      puts "failed test one"
      false
    end
  end
  
  def test_rule_one_point_five
    if @the_set[:w].select{|k,v| v==true}.count > 1
      puts "passed test 1.5"
      true
    else
      puts "failed test 1.5"
      false
    end
  end
  
  def test_rule_two
    forge_owner = @the_set.select{|owner, hsh| hsh[:forge] == true}.flatten.last
    if forge_owner[:inn] == false && forge_owner[:mill] == false
      puts "passed test two"
      true
    else
      puts "failed rule two"
      false
    end
  end
  
  def test_rule_three
    if @the_set[:t][:stable] == true
      puts "passed rule three"
      true
    elsif @the_set[:y][:inn] == true
      puts "pass rule three"
      true
    else
      puts "failed test three"
      false
    end
  end
  
end