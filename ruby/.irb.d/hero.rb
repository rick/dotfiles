# hero.rb - be a production hero, even in ruby land
#
# Come for the `set -e`, stay for the `|| true`
#
#>> set -e
#PRODUCTION HERO SAFETY LEVEL ENGAGE!
#=> nil
#>> set +e
#DISENGAGED. FIGHT STRONG, HERO.
#=> nil
#>> set +e || true
#DISENGAGED. FIGHT STRONG, HERO.
#=> true
#>> 
#
class Object
  def set(other)
    other
  end
  
  def e
    Hero.new
  end
end

class Hero
  def -@()
    puts "PRODUCTION HERO SAFETY LEVEL ENGAGE!"
  end
  
  def +@()
    puts "DISENGAGED. FIGHT STRONG, HERO."
  end
end
