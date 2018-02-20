class KnapsackItem
  attr_accessor :id, :benefit, :weight
  def initialize(attrs)
    @id = attrs[:id]
    @benefit = attrs[:benefit]
    @weight = attrs[:weight]
  end
end

class Knapsack
  attr_reader :items

  def initialize(items = [])
   @items = items 
  end

  def benefits
    @items.reduce(0) do |memo, item|
      memo + item.benefit
    end
  end

  def weight
    @items.reduce(0) do |memo, item|
      memo + item.weight
    end
  end

  def add(item)
    @items.push(item)
  end

  def to_s
    @items.map {|item| item.id}
  end
end

def best_knapsack(items, max_weight, current_knapsack = nil, iteration_count = nil)
  current_knapsack = Knapsack.new([]) if  current_knapsack.nil?
  iteration_count = 0 if iteration_count.nil?

  return Knapsack.new if current_knapsack.weight > 10
  return current_knapsack if iteration_count == items.length

  knapsack_with_n = knapsack_with current_knapsack
  knapsack_with_n.add items[iteration_count]
  knapsack_without_n = knapsack_with current_knapsack

  knapsack_with_n = best_knapsack(items, max_weight,
                                  knapsack_with_n,
                                  iteration_count + 1)
  knapsack_without_n = best_knapsack(items, max_weight, knapsack_without_n, iteration_count + 1)

  if knapsack_with_n.benefits > knapsack_without_n.benefits
    knapsack_with_n
  else
    knapsack_without_n
  end
end

def knapsack_with(knapsack)
  new_knapsack = Knapsack.new
  knapsack.items.each do |item|
    new_knapsack.add item
  end
  new_knapsack
end


items = []
items << KnapsackItem.new(id: 1, weight: 2, benefit: 3)
items << KnapsackItem.new(id: 2, weight: 2, benefit: 7)
items << KnapsackItem.new(id: 3, weight: 4, benefit: 2)
items << KnapsackItem.new(id: 4, weight: 5, benefit: 9)

puts best_knapsack(items, 10).to_s
