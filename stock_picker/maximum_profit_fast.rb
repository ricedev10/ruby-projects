def max_profit(prices)
  profit = 0
  last_price = prices[0]

  prices.each do |price|
    last_price = price if price < last_price

    new_profit = price - last_price
    profit = new_profit if (new_profit) > profit
  end

  profit
end