defmodule Poker do
    def deal([a, b, c, d | table]) do
        playerOneHand = [a, c] ++ table
        playerTwoHand = [b, d] ++ table

        playerOneHand = Enum.sort(playerOneHand)
        playerTwoHand = Enum.sort(playerTwoHand)

        determineWinner(playerOneHand, playerTwoHand)
    end

    def determineWinner(playerOneHand, playerTwoHand) do
        cards = [ nil, 
            "1C", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "11C", "12C", "13C",
            "1D", "2D", "3D", "4D", "5D", "6D", "7D", "8D", "9D", "10D", "11D", "12D", "13D",
		    "1H", "2H", "3H", "4H", "5H", "6H", "7H", "8H", "9H", "10H", "11H", "12H", "13H",
	        "1S", "2S", "3S", "4S", "5S", "6S", "7S", "8S", "9S", "10S", "11S", "12S", "13S" ]

        valueComboOne = evaluateHand(playerOneHand)
        valueComboTwo = evaluateHand(playerTwoHand)

        valueOne = List.first(valueComboOne)
        valueTwo = List.first(valueComboTwo)

        comboOne = List.last(valueComboOne)
        comboTwo = List.last(valueComboTwo)

        cond do
            valueOne > valueTwo -> Enum.map(comboOne, fn index -> Enum.at(cards, index) end)
            valueOne < valueTwo -> Enum.map(comboTwo, fn index -> Enum.at(cards, index) end)
            true -> Enum.map(kicker(valueOne, comboOne, comboTwo, playerOneHand, playerTwoHand), fn index -> Enum.at(cards, index) end)
        end
    end

    def evaluateHand(hand) do
        cond do
            combo = royalFlushCheck(hand)        -> [10, combo]
            combo = straightFlushCheck(hand)     -> [09, combo]
            combo = duplicateCheck(hand, 4, nil) -> [08, combo]
            combo = fullHouseCheck(hand)         -> [07, combo]
            combo = flushCheck(hand)             -> [06, combo]
            combo = straightCheck(hand)          -> [05, combo]
            combo = duplicateCheck(hand, 3, nil) -> [04, combo]
            combo = twoPairCheck(hand)           -> [03, combo]
            combo = duplicateCheck(hand, 2, nil) -> [02, combo]
            true                                 -> [01, getHighCard(hand)]
        end
    end

    def royalFlushCheck(hand) do
        cond do
            MapSet.subset?(MapSet.new([01, 10, 11, 12, 13]), MapSet.new(hand)) -> [01, 10, 11, 12, 13]
            MapSet.subset?(MapSet.new([14, 23, 24, 25, 26]), MapSet.new(hand)) -> [14, 23, 24, 25, 26]
            MapSet.subset?(MapSet.new([27, 36, 37, 38, 39]), MapSet.new(hand)) -> [27, 36, 37, 38, 39]
            MapSet.subset?(MapSet.new([40, 49, 50, 51, 52]), MapSet.new(hand)) -> [40, 49, 50, 51, 52]
            true -> nil
        end
    end

    def straightFlushCheck([ a, b, c, d, e, f, g | _ ]) do
        cond do
            (c + 1 == d) && (c + 2 == e) && (c + 3 == f) && (c + 4 == g) -> [c, d, e, f, g]
            (b + 1 == c) && (b + 2 == d) && (b + 3 == e) && (b + 4 == f) -> [b, c, d, e, f]
            (a + 1 == b) && (a + 2 == c) && (a + 3 == d) && (a + 4 == e) -> [a, b, c, d, e]
            true -> nil
        end
    end

    def fullHouseCheck(hand) do
        triple = duplicateCheck(hand, 3, nil)
        pair   = duplicateCheck(hand, 2, nil)

        cond do
            triple && pair -> triple ++ pair
            true -> nil
        end
    end

    def flushCheck(hand) do
        rankValues = %{"1": 14, "0": 13, "12": 12, "11": 11, "10": 10, "9": 9, "8": 8, "7": 7, "6": 6, "5": 5, "4": 4, "3": 3, "2": 2}
        sortedRanks = Enum.sort(hand, &(rankValues[String.to_atom(Integer.to_string(rem(&1, 13)))] <= rankValues[String.to_atom(Integer.to_string(rem(&2, 13)))]))

        cond do
            Enum.count(hand, fn rank -> rank >= 01 && rank <= 13 end) >= 5 -> Enum.take(Enum.filter(sortedRanks, fn rank -> rank >= 01 && rank <= 13 end), -5)
            Enum.count(hand, fn rank -> rank >= 14 && rank <= 26 end) >= 5 -> Enum.take(Enum.filter(sortedRanks, fn rank -> rank >= 14 && rank <= 26 end), -5)
            Enum.count(hand, fn rank -> rank >= 27 && rank <= 39 end) >= 5 -> Enum.take(Enum.filter(sortedRanks, fn rank -> rank >= 27 && rank <= 39 end), -5)
            Enum.count(hand, fn rank -> rank >= 40 && rank <= 52 end) >= 5 -> Enum.take(Enum.filter(sortedRanks, fn rank -> rank >= 40 && rank <= 52 end), -5)
            true -> nil
        end
    end

    def straightCheck(hand) do
        rankValues = %{ "1": 1, "0": 13, "12": 12, "11": 11, "10": 10, "9": 9, "8": 8, "7": 7, "6": 6, "5": 5, "4": 4, "3": 3, "2": 2 }
        sortedRanks = Enum.sort(hand, &(rankValues[String.to_atom(Integer.to_string(rem(&1, 13)))] <= rankValues[String.to_atom(Integer.to_string(rem(&2, 13)))]))
        noDuplicate = Enum.uniq_by(sortedRanks, fn rank -> rankValues[String.to_atom(Integer.to_string(rem(rank, 13)))] end)
        
        case length(noDuplicate) do
            5 -> getStraight(noDuplicate ++ [-1] ++ [-1], rankValues)
            6 -> getStraight(noDuplicate ++ [-1], rankValues)
            7 -> getStraight(noDuplicate, rankValues)
            true -> nil
        end
    end
    
    def getStraight([ a, b, c, d, e, f, g | _ ], rankValues) do
        aReduced = rankValues[String.to_atom(Integer.to_string(rem(a, 13)))]
        bReduced = rankValues[String.to_atom(Integer.to_string(rem(b, 13)))]
        cReduced = rankValues[String.to_atom(Integer.to_string(rem(c, 13)))]
        dReduced = rankValues[String.to_atom(Integer.to_string(rem(d, 13)))]
        eReduced = rankValues[String.to_atom(Integer.to_string(rem(e, 13)))]
        fReduced = rankValues[String.to_atom(Integer.to_string(rem(f, 13)))]
        gReduced = rankValues[String.to_atom(Integer.to_string(rem(g, 13)))]

        cond do
            (dReduced + 1 == eReduced) && (dReduced + 2 == fReduced) && (dReduced + 3 == gReduced) && (dReduced - aReduced == dReduced - 1) -> [d, e, f, g, a]
            (cReduced + 1 == dReduced) && (cReduced + 2 == eReduced) && (cReduced + 3 == fReduced) && (cReduced - aReduced == cReduced - 1) -> [c, d, e, f, a]
            (bReduced + 1 == cReduced) && (bReduced + 2 == dReduced) && (bReduced + 3 == eReduced) && (bReduced - aReduced == bReduced - 1) -> [b, c, d, e, a]
            (cReduced + 1 == dReduced) && (cReduced + 2 == eReduced) && (cReduced + 3 == fReduced) && (cReduced + 4 == gReduced) -> [c, d, e, f, g]
            (bReduced + 1 == cReduced) && (bReduced + 2 == dReduced) && (bReduced + 3 == eReduced) && (bReduced + 4 == fReduced) -> [b, c, d, e, f]
            (aReduced + 1 == bReduced) && (aReduced + 2 == cReduced) && (aReduced + 3 == dReduced) && (aReduced + 4 == eReduced) -> [a, b, c, d, e]
            true -> nil
        end
    end

    def duplicateCheck(hand, duplicateType, pair) do
        duplicates = for index <- [1, 0, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2] do
            cond do
                Enum.count(hand, fn rank -> rem(rank, 13) == index end) == duplicateType && pair != index -> Enum.filter(hand, fn rank -> rem(rank, 13) == index end)
                true -> nil
            end
        end
        getDuplicate(duplicates)
    end

    def getDuplicate([head | tail]), do: head || getDuplicate(tail)
    def getDuplicate([]), do: nil

    def twoPairCheck(hand) do
        firstPair = duplicateCheck(hand, 2, nil)

        if firstPair do
            secondPair = duplicateCheck(hand, 2, rem(List.first(firstPair), 13))
            cond do
                firstPair && secondPair -> firstPair ++ secondPair
                true -> nil
            end
        end
    end

    def getHighCard(hand) do
        rankValues = %{ "1": 14, "0": 13, "12": 12, "11": 11, "10": 10, "9": 9, "8": 8, "7": 7, "6": 6, "5": 5, "4": 4, "3": 3, "2": 2 }
        sortedRanks = Enum.sort(hand, &(rankValues[String.to_atom(Integer.to_string(rem(&1, 13)))] <= rankValues[String.to_atom(Integer.to_string(rem(&2, 13)))]))
        [List.last(sortedRanks)]
    end

    def kicker(value, comboOne, comboTwo, playerOneHand, playerTwoHand) do
        cond do
            value == 5 or value == 9 -> kickerRank(0.01, comboOne, comboTwo, playerOneHand, playerTwoHand)
            true                     -> kickerRank(0.14, comboOne, comboTwo, playerOneHand, playerTwoHand)
        end
    end

    def kickerRank(aceValue, comboOne, comboTwo, playerOneHand, playerTwoHand) do
        rankValues = %{ "1": aceValue, "0": 0.13, "12": 0.12, "11": 0.11, "10": 0.10, "9": 0.09, "8": 0.08, "7": 0.07, "6": 0.06, "5": 0.05, "4": 0.04, "3": 0.03, "2": 0.02 }

        kickerOne = Enum.map(comboOne, fn rank -> rankValues[String.to_atom(Integer.to_string(rem(rank, 13)))] end)
        kickerTwo = Enum.map(comboTwo, fn rank -> rankValues[String.to_atom(Integer.to_string(rem(rank, 13)))] end)

        cond do
            Enum.sum(kickerOne) > Enum.sum(kickerTwo) -> comboOne
            Enum.sum(kickerOne) < Enum.sum(kickerTwo) -> comboTwo
            true -> kickerWholeHand(comboOne, comboTwo, playerOneHand, playerTwoHand)
        end
    end

    def kickerWholeHand(comboOne, comboTwo, playerOneHand, playerTwoHand) do
        rankValues = %{"1": 14, "0": 13, "12": 12, "11": 11, "10": 10, "9": 9, "8": 8, "7": 7, "6": 6, "5": 5, "4": 4, "3": 3, "2": 2}
        sortedOne  = Enum.sort(playerOneHand, &(rankValues[String.to_atom(Integer.to_string(rem(&1, 13)))] >= rankValues[String.to_atom(Integer.to_string(rem(&2, 13)))]))
        sortedTwo  = Enum.sort(playerTwoHand, &(rankValues[String.to_atom(Integer.to_string(rem(&1, 13)))] >= rankValues[String.to_atom(Integer.to_string(rem(&2, 13)))]))
        reducedOne = Enum.map(sortedOne, fn rank -> rankValues[String.to_atom(Integer.to_string(rem(rank, 13)))] end)
        reducedTwo = Enum.map(sortedTwo, fn rank -> rankValues[String.to_atom(Integer.to_string(rem(rank, 13)))] end)
        
        cardWinner = for index <- [0, 1, 2, 3, 4, 5, 6] do
            cond do
                Enum.at(reducedOne, index) > Enum.at(reducedTwo, index) -> comboOne
                Enum.at(reducedOne, index) < Enum.at(reducedTwo, index) -> comboTwo
                true -> nil
            end
        end

        getCombo(cardWinner)
    end

    def getCombo([head | tail]), do: head || getCombo(tail)
    def getCombo([]), do: nil
end

# 164 Lines
