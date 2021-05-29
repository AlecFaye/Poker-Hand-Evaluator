module TestPoker where

import Poker
import Test.HUnit

-- ROYAL FLUSH PATTERN TESTS --
testRoyalFlush =
  TestLabel "RoyalFlush --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "RoyalFlush: Player 1 should win."
            ["10S", "11S", "12S", "13S", "1S"]
            (deal [40, 41, 42, 43, 48, 49, 50, 51, 52]),
          assertEqual
            "RoyalFlush: Player 1 should win."
            ["10H", "11H", "12H", "13H", "1H"]
            (deal [27, 13, 38, 26, 34, 47, 36, 37, 39])
        ]

testRoyalFlush2 =
  TestLabel "RoyalFlush --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "RoyalFlush: Player 2 should win."
            ["10S", "11S", "12S", "13S", "1S"]
            (deal [41, 40, 43, 42, 48, 49, 50, 51, 52]),
          assertEqual
            "RoyalFlush: Player 2 should win."
            ["10H", "11H", "12H", "13H", "1H"]
            (deal [13, 27, 26, 38, 34, 47, 36, 37, 39])
        ]

-- STRAIGHT FLUSH PATTERN TESTS --
testStraightFlush =
  TestLabel "StraightFlush --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "StraightFlush: Player 1 should win."
            ["6H", "7H", "8H", "9H", "10H"]
            (deal [32, 17, 33, 18, 19, 20, 34, 35, 36]),
          assertEqual
            "StraightFlush: Player 1 should win."
            ["7H", "8H", "9H", "10H", "11H"]
            (deal [32, 17, 33, 18, 34, 35, 36, 37, 38]),
          assertEqual
            "StraightFlush: Player 1 should win."
            ["4S", "5S", "6S", "7S", "8S"]
            (deal [42, 27, 43, 28, 45, 44, 46, 48, 47]),
          assertEqual
            "StraightFlush: Player 1 should win."
            ["6S", "7S", "8S", "9S", "10S"]
            (deal [43, 27, 49, 28, 45, 44, 46, 47, 48])
        ]

testStraightFlush2 =
  TestLabel "StraightFlush --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "StraightFlush: Player 2 should win."
            ["6H", "7H", "8H", "9H", "10H"]
            (deal [17, 32, 18, 33, 19, 20, 34, 35, 36]),
          assertEqual
            "StraightFlush: Player 2 should win."
            ["7H", "8H", "9H", "10H", "11H"]
            (deal [17, 32, 18, 33, 34, 35, 36, 37, 38]),
          assertEqual
            "StraightFlush: Player 2 should win."
            ["4S", "5S", "6S", "7S", "8S"]
            (deal [27, 42, 28, 43, 45, 44, 46, 48, 47]),
          assertEqual
            "StraightFlush: Player 2 should win."
            ["6S", "7S", "8S", "9S", "10S"]
            (deal [27, 43, 28, 49, 45, 44, 46, 47, 48])
        ]

testStraightFlush3 =
  TestLabel "StraightFlush --> KICKER --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "StraightFlush: (Kicker) Player 1 should win."
            ["2C", "3C", "4C", "5C", "6C"]
            (deal [8, 9, 6, 7, 5, 4, 3, 2, 1]),
          assertEqual
            "StraightFlush: (Kicker) Player 1 should win."
            ["9H", "10H", "11H", "12H", "13H"]
            (deal [32, 31, 39, 33, 34, 35, 36, 37, 38]),
          assertEqual
            "StraightFlush: (Kicker) Player 1 should win."
            ["8H", "9H", "10H", "11H", "12H"]
            (deal [31, 30, 38, 32, 33, 34, 35, 36, 37]),
          assertEqual
            "StraightFlush: (Kicker) Player 1 should win."
            ["7S", "8S", "9S", "10S", "11S"]
            (deal [47, 42, 50, 43, 44, 45, 46, 48, 49]),
          assertEqual
            "StraightFlush: (Kicker) Player 1 should win."
            ["5D", "6D", "7D", "8D", "9D"]
            (deal [19, 14, 22, 15, 16, 17, 20, 21, 18]),
          assertEqual
            "StraightFlush: (Kicker) Player 1 should win."
            ["6S", "7S", "8S", "9S", "10S"]
            (deal [31, 27, 49, 43, 44, 45, 46, 47, 48]),
          assertEqual
            "StraightFlush: (Kicker) Player 1 should win."
            ["6C", "7C", "8C", "9C", "10C"]
            (deal [21, 20, 22, 19, 6, 7, 8, 9, 10])
        ]

testStraightFlush4 =
  TestLabel "StraightFlush --> KICKER --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "StraightFlush: (Kicker) Player 2 should win."
            ["2C", "3C", "4C", "5C", "6C"]
            (deal [9, 8, 7, 6, 5, 4, 3, 2, 1]),
          assertEqual
            "StraightFlush: (Kicker) Player 2 should win."
            ["9H", "10H", "11H", "12H", "13H"]
            (deal [31, 32, 33, 39, 34, 35, 36, 37, 38]),
          assertEqual
            "StraightFlush: (Kicker) Player 2 should win."
            ["8H", "9H", "10H", "11H", "12H"]
            (deal [30, 31, 32, 38, 33, 34, 35, 36, 37]),
          assertEqual
            "StraightFlush: (Kicker) Player 2 should win."
            ["7S", "8S", "9S", "10S", "11S"]
            (deal [42, 47, 43, 50, 44, 45, 46, 48, 49]),
          assertEqual
            "StraightFlush: (Kicker) Player 2 should win."
            ["5D", "6D", "7D", "8D", "9D"]
            (deal [14, 19, 15, 22, 16, 17, 20, 21, 18]),
          assertEqual
            "StraightFlush: (Kicker) Player 2 should win."
            ["6S", "7S", "8S", "9S", "10S"]
            (deal [27, 31, 43, 49, 44, 45, 46, 47, 48]),
          assertEqual
            "StraightFlush: (Kicker) Player 1 should win."
            ["6C", "7C", "8C", "9C", "10C"]
            (deal [20, 21, 19, 22, 6, 7, 8, 9, 10])
        ]

-- FOUR OF KIND PATTERN TESTS --
testFourOfKind =
  TestLabel "FourOfKind --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "FourOfKind: Player 1 should win."
            ["1C", "1D", "1H", "1S"]
            (deal [40, 41, 27, 28, 1, 14, 15, 42, 29])
        ]

testFourOfKind2 =
  TestLabel "FourOfKind --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "FourOfKind: Player 2 should win."
            ["1C", "1D", "1H", "1S"]
            (deal [41, 40, 28, 27, 1, 14, 15, 42, 29])
        ]

testFourOfKind3 =
  TestLabel "FourOfKind --> KICKER --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "HighRank: (Kicker) Player 1 should win."
            ["8C", "8D", "8H", "8S"]
            (deal [17, 3, 5, 4, 8, 9, 21, 34, 47]),
          assertEqual
            "HighRank: (Kicker) Player 1 should win."
            ["7C", "7D", "7H", "7S"]
            (deal [1, 2, 4, 14, 7, 20, 33, 46, 8])
        ]

testFourOfKind4 =
  TestLabel "FourOfKind --> KICKER --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "HighRank: (Kicker) Player 2 should win."
            ["8C", "8D", "8H", "8S"]
            (deal [3, 17, 4, 5, 8, 9, 21, 34, 47]),
          assertEqual
            "HighRank: (Kicker) Player 2 should win."
            ["7C", "7D", "7H", "7S"]
            (deal [2, 1, 14, 4, 7, 20, 33, 46, 8])
        ]

-- FULL HOUSE PATTERN TESTS --
testFullHouse =
  TestLabel "FullHouse --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "FullHouse: Player 1 should win."
            ["12C", "12D", "12S", "13H", "13S"]
            (deal [17, 39, 30, 52, 44, 25, 41, 51, 12])
        ]

testFullHouse2 =
  TestLabel "FullHouse --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "FullHouse: Player 1 should win."
            ["12C", "12D", "12S", "13H", "13S"]
            (deal [39, 17, 52, 30, 44, 25, 41, 51, 12])
        ]

-- FLUSH PATTERN TESTS --
testFlush =
  TestLabel "Flush --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "Flush: Player 1 should win."
            ["2S", "4S", "5S", "6S", "9S"]
            (deal [27, 45, 3, 48, 44, 43, 41, 33, 12]),
          assertEqual
            "Flush: Player 1 should win."
            ["1C", "4C", "6C", "7C", "10C"]
            (deal [1, 16, 14, 17, 4, 6, 7, 10, 11]),
          assertEqual
            "Flush: Player 1 should win."
            ["3D", "6D", "8D", "9D", "12D"]
            (deal [16, 31, 29, 32, 19, 21, 22, 34, 25]),
          assertEqual
            "Flush: Player 1 should win."
            ["3D", "6D", "8D", "9D", "13D"]
            (deal [16, 31, 26, 32, 19, 21, 22, 34, 47]),
          assertEqual
            "Flush: Player 1 should win."
            ["1C", "6C", "8C", "9C", "10C"]
            (deal [1, 3, 14, 4, 6, 19, 8, 9, 10])
        ]

testFlush2 =
  TestLabel "Flush --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "Flush: Player 2 should win."
            ["2S", "4S", "5S", "6S", "9S"]
            (deal [45, 27, 48, 3, 44, 43, 41, 33, 12]),
          assertEqual
            "Flush: Player 2 should win."
            ["1C", "4C", "6C", "7C", "10C"]
            (deal [16, 1, 17, 14, 4, 6, 7, 10, 11]),
          assertEqual
            "Flush: Player 2 should win."
            ["3D", "6D", "8D", "9D", "12D"]
            (deal [31, 16, 32, 29, 19, 21, 22, 34, 25]),
          assertEqual
            "Flush: Player 2 should win."
            ["3D", "6D", "8D", "9D", "13D"]
            (deal [31, 16, 32, 26, 19, 21, 22, 34, 47]),
          assertEqual
            "Flush: Player 2 should win."
            ["1C", "6C", "8C", "9C", "10C"]
            (deal [3, 1, 4, 14, 6, 19, 8, 9, 10])
        ]

testFlush3 =
  TestLabel "Flush --> KICKER --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "Flush: (Kicker) Player 1 should win."
            ["3D", "6D", "8D", "9D", "13D"]
            (deal [16, 15, 26, 20, 19, 21, 22, 34, 47])
        ]

testFlush4 =
  TestLabel "Flush --> KICKER --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "Flush: (Kicker) Player 2 should win."
            ["3D", "6D", "8D", "9D", "13D"]
            (deal [15, 16, 20, 26, 19, 21, 22, 34, 47])
        ]

-- THREE OF KIND PATTERN TESTS --
testThreeOfKind =
  TestLabel "ThreeOfKind --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "ThreeOfKind: Player 1 should win."
            ["4D", "4H", "4S"]
            (deal [17, 31, 30, 51, 44, 43, 41, 33, 12]),
          assertEqual
            "ThreeOfKind: Player 1 should win."
            ["1C", "1D", "1S"]
            (deal [2, 1, 13, 40, 14, 15, 16, 17, 52]),
          assertEqual
            "ThreeOfKind: Player 1 should win."
            ["5D", "5H", "5S"]
            (deal [2, 18, 13, 31, 44, 15, 16, 17, 52])
        ]

testThreeOfKind2 =
  TestLabel "ThreeOfKind --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "ThreeOfKind: Player 2 should win."
            ["4D", "4H", "4S"]
            (deal [31, 17, 51, 30, 44, 43, 41, 33, 12]),
          assertEqual
            "ThreeOfKind: Player 2 should win."
            ["1C", "1D", "1S"]
            (deal [1, 2, 40, 13, 14, 15, 16, 17, 52]),
          assertEqual
            "ThreeOfKind: Player 2 should win."
            ["5D", "5H", "5S"]
            (deal [18, 2, 31, 13, 44, 15, 16, 17, 52])
        ]

testThreeOfKind3 =
  TestLabel "ThreeOfKind --> Kicker--> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "ThreeOfKind: (Kicker) Player 1 should win."
            ["1C", "1D", "1S"]
            (deal [1, 2, 40, 28, 14, 15, 16, 17, 52]),
          assertEqual
            "ThreeOfKind: (Kicker) Player 2 should win."
            ["4D", "4H", "4S"]
            (deal [13, 30, 44, 27, 12, 17, 33, 41, 43])
        ]

testThreeOfKind4 =
  TestLabel "ThreeOfKind --> Kicker--> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "ThreeOfKind: (Kicker) Player 2 should win."
            ["1C", "1D", "1S"]
            (deal [2, 1, 28, 40, 14, 15, 16, 17, 52]),
          assertEqual
            "ThreeOfKind: (Kicker) Player 2 should win."
            ["4D", "4H", "4S"]
            (deal [30, 13, 27, 44, 12, 17, 33, 41, 43])
        ]

-- TWO PAIR PATTERN TESTS --
testTwoPair =
  TestLabel "TwoPair --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "TwoPair: Player 1 should win."
            ["11C", "11S", "13H", "13S"]
            (deal [50, 26, 39, 3, 11, 27, 20, 48, 52]),
          assertEqual
            "TwoPair: Player 1 should win."
            ["1C", "1D", "8D", "8H"]
            (deal [1, 13, 14, 26, 18, 6, 7, 21, 34]),
          assertEqual
            "TwoPair: Player 1 should win."
            ["8D", "8H", "13C", "13D"]
            (deal [2, 13, 15, 26, 18, 6, 7, 21, 34])
        ]

testTwoPair2 =
  TestLabel "TwoPair --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "TwoPair: Player 2 should win."
            ["11C", "11S", "13H", "13S"]
            (deal [26, 50, 3, 39, 11, 27, 20, 48, 52]),
          assertEqual
            "TwoPair: Player 1 should win."
            ["1C", "1D", "8D", "8H"]
            (deal [13, 1, 26, 14, 18, 6, 7, 21, 34]),
          assertEqual
            "TwoPair: Player 1 should win."
            ["8D", "8H", "13C", "13D"]
            (deal [13, 2, 26, 15, 18, 6, 7, 21, 34])
        ]

testTwoPair3 =
  TestLabel "TwoPair --> KICKER --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "TwoPair: (Kicker) Player 1 should win."
            ["11C", "11S", "13H", "13S"]
            (deal [50, 6, 39, 26, 32, 20, 48, 11, 52]),
          assertEqual
            "TwoPair: (Kicker) Player 1 should win."
            ["10C", "10S", "12H", "12S"]
            (deal [49, 5, 38, 25, 31, 19, 47, 10, 51]),
          assertEqual
            "TwoPair: (Kicker) Player 1 should win."
            ["8C", "8H", "10H", "10S"]
            (deal [34, 3, 36, 23, 29, 17, 45, 8, 49]),
          assertEqual
            "TwoPair: (Kicker) Player 1 should win."
            ["1C", "1H", "8D", "8S"]
            (deal [1, 32, 21, 34, 27, 15, 43, 6, 47]),
          assertEqual
            "TwoPair: (Kicker) Player 1 should win."
            ["1C", "1D", "7C", "7D"]
            (deal [14, 18, 20, 26, 1, 5, 7, 9, 13])
        ]

testTwoPair4 =
  TestLabel "TwoPair --> KICKER --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "TwoPair: (Kicker) Player 2 should win."
            ["11C", "11S", "13H", "13S"]
            (deal [6, 50, 26, 39, 32, 20, 48, 11, 52]),
          assertEqual
            "TwoPair: (Kicker) Player 1 should win."
            ["10C", "10S", "12H", "12S"]
            (deal [5, 49, 25, 38, 31, 19, 47, 10, 51]),
          assertEqual
            "TwoPair: (Kicker) Player 1 should win."
            ["8C", "8H", "10H", "10S"]
            (deal [3, 34, 23, 36, 29, 17, 45, 8, 49]),
          assertEqual
            "TwoPair: (Kicker) Player 1 should win."
            ["1C", "1H", "8D", "8S"]
            (deal [32, 1, 34, 21, 27, 15, 43, 6, 47])
        ]

-- PAIR PATTERN TESTS --
testPair =
  TestLabel "Pair --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "Pair: Player 1 should win."
            ["13C", "13S"]
            (deal [13, 25, 8, 20, 40, 2, 16, 52, 51])
        ]

testPair2 =
  TestLabel "Pair --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "Pair: Player 2 should win."
            ["13C", "13S"]
            (deal [25, 13, 20, 8, 40, 2, 16, 52, 51])
        ]

testPair3 =
  TestLabel "Pair --> KICKER --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "Pair: (Kicker) Player 1 should win."
            ["1H", "1S"]
            (deal [40, 52, 46, 11, 48, 27, 29, 32, 37])
        ]

testPair4 =
  TestLabel "Pair --> KICKER --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "Pair: (Kicker) Player 2 should win."
            ["1H", "1S"]
            (deal [52, 40, 11, 46, 48, 27, 29, 32, 37])
        ]

-- HIGH RANK PATTERN TESTS --
testHighRank =
  TestLabel "HighRank --> Hand 1" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "HighRank: Player 1 should win."
            ["1S"]
            (deal [40, 2, 3, 50, 20, 8, 9, 12, 26]),
          assertEqual
            "HighRank: Player 1 should win."
            ["10S"]
            (deal [41, 3, 4, 49, 19, 7, 8, 11, 25]),
          assertEqual
            "HighRank: Player 1 should win."
            ["11S"]
            (deal [42, 4, 5, 50, 20, 8, 9, 12, 26])
        ]

testHighRank2 =
  TestLabel "HighRank --> Hand 2" $
    TestList $
      fmap
        TestCase
        [ assertEqual
            "HighRank: Player 2 should win."
            ["1S"]
            (deal [2, 40, 50, 3, 20, 8, 9, 12, 26]),
          assertEqual
            "HighRank: Player 1 should win."
            ["10S"]
            (deal [3, 41, 49, 4, 19, 7, 8, 11, 25]),
          assertEqual
            "HighRank: Player 1 should win."
            ["11S"]
            (deal [4, 42, 50, 5, 20, 8, 9, 12, 26])
        ]

main :: IO Counts
main =
  runTestTT $
    TestList
      [ testRoyalFlush,
        testRoyalFlush2,
        testStraightFlush,
        testStraightFlush2,
        testStraightFlush3,
        testStraightFlush4,
        testFourOfKind,
        testFourOfKind2,
        testFourOfKind3,
        testFourOfKind4,
        testFullHouse,
        testFullHouse2,
        testFlush,
        testFlush2,
        testFlush3,
        testFlush4,
        testThreeOfKind,
        testThreeOfKind2,
        testThreeOfKind3,
        testThreeOfKind4,
        testTwoPair,
        testTwoPair2,
        testTwoPair3,
        testTwoPair4,
        testPair,
        testPair2,
        testPair3,
        testPair4,
        testHighRank,
        testHighRank2
      ]