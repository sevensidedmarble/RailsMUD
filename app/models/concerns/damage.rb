class Damage
  attr_accessor :damage_type, :amount

  def initialize(type, amount)
    @damage_type = type
    @amount = amount
  end
end