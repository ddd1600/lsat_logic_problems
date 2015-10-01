class LogicProblem1
  attr_reader :the_set
#the question
#During the seventeenth century, three families--the Trents, the Williamses, and the Yandells--owned
#five buildings that consituted the center of their village--the forge, the granary, the inn, the mill, and the
#stable. Each family owned at least one of the buildings and each building was owned by exactly one of the families.
#The historical evidence established the following about the ownership of the villages:
#  - The Williamses owned more buildings than the Yandells owned
#  - Neither the inn nore the mill belonged to the owner of the forge.
#  - Either the Trents owned the stable or the Yandells owned the inn, or both.
#
#  See images for the questions

  def initialize
    @families = {:t => "Trents", :w => "Williamses", :y => "Yandells"}
    @buildings = {:m => :mill, :f => :forge, :g => :granary, :i => :inn, :s => :stable}
  end
  
  def go
    #gathering information from the user. don't worry too much about this logic, its very....unnecessary to focus on at this point
    @the_set = {}
    [:t, :w, :y].each do |family|
      puts "in a comma separated list, write the first letter of each property owned by the #{@families[family]}"
      STDOUT.flush
      resp = gets.chomp
      hsh = {:mill => false, :forge => false, :granary => false, :inn => false, :stable => false}
      resp.downcase.gsub(" ", "").split(",").each do |bldg|
        hsh[@buildings[bldg.to_sym]] = true
      end
      @the_set[family] = hsh
    end
    #ok now that we've collected the information from the user, run the tests that all will return 'true' or 'false'
    results = []
    results << test_rule_one
    results << test_rule_one_point_five
    results << test_rule_two
    results << test_rule_three
    if results.contain?(false)# "1 strike and you're out" logic
      false
    else
      true
  end
  
  
  def test_rule_one
    if @the_set[:w].select{|k,v| v == true}.count > @the_set[:y].select{|k,v| v == true}.count
      puts "passed test one"
      true
    else # if the W DOES NOT has more buildings than Y, return false with regards to logical possibility
      puts "failed test one"
      false
    end
  end
  
  def test_rule_one_point_five
    if @the_set[:w].select{|k,v| v==true}.count > 1
      puts "passed test 1.5"
      true
    else# If W DOES NOT have more than 1 building, return false
      puts "failed test 1.5"
      false
    end
  end
  
  def test_rule_two
    forge_owner = @the_set.select{|owner, hsh| hsh[:forge] == true}.flatten.last
    if forge_owner[:inn] == false && forge_owner[:mill] == false #if the forge owner DOES NOT own an Inn or a Mill, return true
      puts "passed test two"
      true
    else# otherwise the implication is that the forge owner does have an inn or a mill and so returns false
      puts "failed rule two"
      false
    end
  end
  
  def test_rule_three # one or the other will return true. no need to even cover the "OR BOTH" situation, as it turns out
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

loop do
  puts "restarting loop. press ctrl-c to break out"
  LogicProblem1.new.go
end

