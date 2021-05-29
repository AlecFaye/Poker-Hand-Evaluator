import Poker

IO.inspect Poker.deal([ 09, 08, 07, 06, 03, 01, 04, 05, 02 ]), label: "Answer: [  2C   3C   4C   5C   6C ] === Actual"
IO.inspect Poker.deal([ 18, 15, 25, 43, 17, 08, 29, 47, 27 ]), label: "Answer: [  8C   8S   4D   4S      ] === Actual"
IO.inspect Poker.deal([ 32, 16, 09, 05, 39, 49, 06, 43, 08 ]), label: "Answer: [  6C   6H                ] === Actual"
IO.inspect Poker.deal([ 19, 38, 52, 31, 44, 41, 05, 15, 01 ]), label: "Answer: [  5C   5H   5S   2D   2S ] === Actual"
IO.inspect Poker.deal([ 09, 21, 52, 17, 45, 41, 10, 42, 02 ]), label: "Answer: [  2C   2S                ] === Actual"
IO.inspect Poker.deal([ 14, 08, 35, 06, 27, 26, 46, 25, 21 ]), label: "Answer: [  1D   1H                ] === Actual"
IO.inspect Poker.deal([ 46, 35, 30, 52, 38, 39, 37, 26, 29 ]), label: "Answer: [ 13H  12H  11H   9H   3H ] === Actual"
IO.inspect Poker.deal([ 19, 27, 24, 33, 10, 28, 42, 01, 07 ]), label: "Answer: [  1C   7C   1H   7H      ] === Actual"
IO.inspect Poker.deal([ 33, 38, 09, 27, 13, 17, 25, 34, 39 ]), label: "Answer: [ 13C  12D  12H  13H      ] === Actual"
IO.inspect Poker.deal([ 12, 52, 34, 18, 43, 27, 37, 13, 29 ]), label: "Answer: [ 13C  13S                ] === Actual"
IO.inspect Poker.deal([ 15, 13, 18, 28, 24, 01, 41, 12, 07 ]), label: "Answer: [  2H   2S                ] === Actual"
IO.inspect Poker.deal([ 21, 25, 09, 20, 03, 47, 51, 16, 29 ]), label: "Answer: [  3C   3D  12D   3H  12S ] === Actual"
IO.inspect Poker.deal([ 41, 26, 23, 52, 22, 06, 19, 30, 07 ]), label: "Answer: [  6C   6D  13D  13S      ] === Actual"
IO.inspect Poker.deal([ 49, 46, 28, 51, 24, 07, 47, 16, 20 ]), label: "Answer: [  7C   7D   7S           ] === Actual"
IO.inspect Poker.deal([ 10, 13, 23, 47, 41, 01, 18, 05, 36 ]), label: "Answer: [  5C  10C   5D  10D  10H ] === Actual"
IO.inspect Poker.deal([ 27, 44, 14, 34, 05, 15, 13, 21, 39 ]), label: "Answer: [ 13C   1D   1H  13H      ] === Actual"
IO.inspect Poker.deal([ 28, 41, 31, 40, 42, 15, 27, 07, 45 ]), label: "Answer: [  2D   1H   1S   2S      ] === Actual"
IO.inspect Poker.deal([ 32, 45, 21, 49, 28, 46, 41, 52, 48 ]), label: "Answer: [ 13S  10S   9S   7S   6S ] === Actual"
IO.inspect Poker.deal([ 01, 11, 31, 13, 48, 17, 51, 46, 20 ]), label: "Answer: [  7D   7S                ] === Actual"
IO.inspect Poker.deal([ 42, 09, 13, 20, 43, 02, 14, 15, 39 ]), label: "Answer: [  2C  13C   2D  13H      ] === Actual"
IO.inspect Poker.deal([ 33, 27, 21, 46, 45, 14, 11, 25, 36 ]), label: "Answer: [  1D   1H                ] === Actual"

            cond do
                Enum.count(hand, fn rank -> rem(rank, 13) == 01 end) == duplicateType && pair != 01 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 01 end)
                Enum.count(hand, fn rank -> rem(rank, 13) == 00 end) == duplicateType && pair != 00 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 00 end)
                Enum.count(hand, fn rank -> rem(rank, 13) == 12 end) == duplicateType && pair != 12 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 12 end)
                Enum.count(hand, fn rank -> rem(rank, 13) == 11 end) == duplicateType && pair != 11 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 11 end)
                Enum.count(hand, fn rank -> rem(rank, 13) == 10 end) == duplicateType && pair != 10 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 10 end)
                Enum.count(hand, fn rank -> rem(rank, 13) == 09 end) == duplicateType && pair != 09 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 09 end)
                Enum.count(hand, fn rank -> rem(rank, 13) == 08 end) == duplicateType && pair != 08 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 08 end)
                Enum.count(hand, fn rank -> rem(rank, 13) == 07 end) == duplicateType && pair != 07 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 07 end)
                Enum.count(hand, fn rank -> rem(rank, 13) == 06 end) == duplicateType && pair != 06 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 06 end)
                Enum.count(hand, fn rank -> rem(rank, 13) == 05 end) == duplicateType && pair != 05 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 05 end)
                Enum.count(hand, fn rank -> rem(rank, 13) == 04 end) == duplicateType && pair != 04 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 04 end)
                Enum.count(hand, fn rank -> rem(rank, 13) == 03 end) == duplicateType && pair != 03 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 03 end)
                Enum.count(hand, fn rank -> rem(rank, 13) == 02 end) == duplicateType && pair != 02 -> Enum.filter(hand, fn rank -> rem(rank, 13) == 02 end)
                true -> nil
            end

            cond do 
            Enum.at(reducedOne, 0) > Enum.at(reducedTwo, 0) -> comboOne
            Enum.at(reducedOne, 0) < Enum.at(reducedTwo, 0) -> comboTwo
            Enum.at(reducedOne, 1) > Enum.at(reducedTwo, 1) -> comboOne
            Enum.at(reducedOne, 1) < Enum.at(reducedTwo, 1) -> comboTwo
            Enum.at(reducedOne, 2) > Enum.at(reducedTwo, 2) -> comboOne
            Enum.at(reducedOne, 2) < Enum.at(reducedTwo, 2) -> comboTwo
            Enum.at(reducedOne, 3) > Enum.at(reducedTwo, 3) -> comboOne
            Enum.at(reducedOne, 3) < Enum.at(reducedTwo, 3) -> comboTwo
            Enum.at(reducedOne, 4) > Enum.at(reducedTwo, 4) -> comboOne
            Enum.at(reducedOne, 4) < Enum.at(reducedTwo, 4) -> comboTwo
            Enum.at(reducedOne, 5) > Enum.at(reducedTwo, 5) -> comboOne
            Enum.at(reducedOne, 5) < Enum.at(reducedTwo, 5) -> comboTwo
            Enum.at(reducedOne, 6) > Enum.at(reducedTwo, 6) -> comboOne
            Enum.at(reducedOne, 6) < Enum.at(reducedTwo, 6) -> comboTwo
            true -> nil
        end