class KnapsackItem
  attr_accessor :id, :benefit, :weight
  def initialize(attrs)
    @id = attrs[:id]
    @benefit = attrs[:benefit]
    @weight = attrs[:weight]
  end
end

def items_to_weight_benefit_matrix(items, max_weight)
  items_to_weight_arr = items.map { |arr| [0]}
  items.each_with_index do |item, index|
    (1..max_weight).to_a.each do |weight|

      previous_row_index = index > 0 ? index - 1 : 0
      previous_value = items_to_weight_arr[previous_row_index][weight]
      previous_value = 0 if previous_value.nil?

      target_index = weight - item.weight
      target_index = target_index < 0 ? 0 : target_index

      if item.weight > weight
        current_row_value = items_to_weight_arr[index][target_index]
        items_to_weight_arr[index][weight] = [current_row_value, previous_value].max
      else
        previous_row_value = index > 0 ? items_to_weight_arr[previous_row_index][target_index] : 0
        value_with_current_item = item.benefit + previous_row_value
        items_to_weight_arr[index][weight] = [value_with_current_item, previous_value].max
      end
    end
  end
  items_to_weight_arr
end


def best_knapsack(items, max_weight)
  selected_items = []
  benefit_matrix = items_to_weight_benefit_matrix(items, max_weight)

  current_row = items.length - 1
  current_column = max_weight
  current_benefit = benefit_matrix[current_row][current_column]

  while current_benefit != 0 && current_row >= 0
    if benefit_matrix[current_row - 1][current_column] !=
      benefit_matrix[current_row][current_column]

      selected_items << items[current_row]

      current_column = current_column - items[current_row].weight
      current_row = current_row - 1
      current_benefit = benefit_matrix[current_row][current_column]
    else
      current_row = current_row - 1
      current_benefit = benefit_matrix[current_row][current_column]
    end
  end

  selected_items
end

items = []
items << KnapsackItem.new(id: 1, weight: 2, benefit: 3)
items << KnapsackItem.new(id: 2, weight: 2, benefit: 7)
items << KnapsackItem.new(id: 3, weight: 4, benefit: 2)
items << KnapsackItem.new(id: 4, weight: 5, benefit: 9)

puts best_knapsack(items, 10).to_s
