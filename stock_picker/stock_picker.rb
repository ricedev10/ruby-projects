def stock_picker(prices)
  buy_day, sell_day = 0, 0
  searching_day = 0

  prices.each_with_index do |price, day|
    if price < prices[searching_day]
      searching_day = day
    end

    if (price - prices[searching_day]) > (prices[sell_day] - prices[buy_day])
      buy_day = searching_day
      sell_day = day
    end
  end

  [buy_day, sell_day]
end

p stock_picker([17,3,6,9,15,8,6,1,10])