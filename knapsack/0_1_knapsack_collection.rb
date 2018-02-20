class Knapsack
  def initialize
    @possible_items = []
    @max_weight = 10
  end

  def add(item)
    @possible_items << item
  end

  def best_inventory
    collections = all_possible_collections.reject do |collection|
      @max_weight < collection.map{ |i| i[:weight] }.reduce(0, :+)
    end.reduce do |collection, memo|
      if memo.nil?
        collection
      else
        benefit_from(collection) > benefit_from(memo) ? collection : memo
      end
    end
    collections.to_s
  end

  private

  def benefit_from(collection)
    collection.map{ |i| i[:benefit] }.reduce(0, :+)
  end

  def all_possible_collections
    possible_collections = []
    possible_collections << []
    @possible_items.each do |item|
      new_collections = possible_collections.map do |collection|
        new_collection = []
        new_collection.concat collection
        new_collection << item
      end
      possible_collections.concat new_collections
    end
    return possible_collections
  end
end

knapsack = Knapsack.new()
knapsack.add({id: 1, weight: 2, benefit: 3})
knapsack.add({id: 2, weight: 2, benefit: 7})
knapsack.add({id: 3, weight: 4, benefit: 2})
knapsack.add({id: 4, weight: 5, benefit: 9})

puts knapsack.best_inventory
