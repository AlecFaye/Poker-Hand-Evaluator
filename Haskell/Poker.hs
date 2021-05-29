-- Tran Kelvin Lim (500769478)
-- Section 01
-- Brian Bao Nguyen (500818362)
-- Section 05

module Poker where
    
    import Text.Printf

    cardValues = [ "empty", "1C", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "11C", "12C", "13C", "1D", "2D", "3D", "4D", "5D", "6D", "7D", "8D", "9D", "10D", "11D", "12D", "13D", "1H", "2H", "3H", "4H", "5H", "6H", "7H", "8H", "9H", "10H", "11H", "12H", "13H", "1S", "2S", "3S", "4S", "5S", "6S", "7S", "8S", "9S", "10S", "11S", "12S", "13S" ]

    deal cards = determineWinner (playerOneHand cards) (playerTwoHand cards) cards

    playerOneHand cards = quickSort [ snd x | x <- (zip [0..] cards), fst x /= 1 && fst x /= 3 ]
    playerTwoHand cards = quickSort [ snd x | x <- (zip [0..] cards), fst x /= 0 && fst x /= 2 ]

    quickSort [] = []
    quickSort (x:xs) = quickSort [ y | y <- xs, y `mod` 13 <= x `mod` 13 ] ++ [x] ++ quickSort [ y | y <- xs, y `mod` 13 > x `mod` 13 ]

    determineWinner p1Hand p2Hand cards
        | valueOne > valueTwo = translate comboOne
        | valueOne < valueTwo = translate comboTwo
        | otherwise = translate (kicker valueOne comboOne comboTwo cards)
        where 
            valueOne = fst (evaluateHand p1Hand)
            comboOne = snd (evaluateHand p1Hand)
            valueTwo = fst (evaluateHand p2Hand)
            comboTwo = snd (evaluateHand p2Hand)
    
    translate hand = [ cardValues !! x | x <- hand ]

    evaluateHand hand 
        | fst royalFlushHand    = (10, snd royalFlushHand)
        | fst straightFlushHand = (09, snd straightFlushHand)
        | fst fourOfAKindHand   = (08, snd fourOfAKindHand)
        | fst fullHouseHand     = (07, snd fullHouseHand)
        | fst flushHand         = (06, snd flushHand)
        | fst straightHand      = (05, snd straightHand)
        | fst tripleHand        = (04, snd tripleHand)
        | fst twoPairHand       = (03, snd twoPairHand)
        | fst pairHand          = (02, snd pairHand)
        | otherwise             = (01, getHighCard hand)
        where 
            royalFlushHand    = royalFlushCheck hand
            straightFlushHand = straightFlushCheck hand
            fourOfAKindHand   = duplicateCheck hand 4 (-1)
            fullHouseHand     = fullHouseCheck hand
            flushHand         = flushCheck hand
            straightHand      = straightCheck hand
            tripleHand        = duplicateCheck hand 3 (-1)
            twoPairHand       = twoPairCheck hand
            pairHand          = duplicateCheck hand 2 (-1)

    royalFlushCheck hand
        | clubs    == [ x | x <- hand, x `elem` clubs    ] = (True, clubs)
        | diamonds == [ x | x <- hand, x `elem` diamonds ] = (True, diamonds)
        | hearts   == [ x | x <- hand, x `elem` hearts   ] = (True, hearts)
        | spades   == [ x | x <- hand, x `elem` spades   ] = (True, spades)
        | otherwise = (False, [])
        where 
            clubs    = [13, 01, 10, 11, 12]
            diamonds = [26, 14, 23, 24, 25]
            hearts   = [39, 27, 36, 37, 38]
            spades   = [52, 40, 49, 50, 51]

    straightFlushCheck hand
        | c + 1 == d && c + 2 == e && c + 3 == f && c + 4 == g = (True, [ c, d, e, f, g ])
        | b + 1 == c && b + 2 == d && b + 3 == e && b + 4 == f = (True, [ b, c, d, e, f ])
        | a + 1 == b && a + 2 == c && a + 3 == d && a + 4 == e = (True, [ a, b, c, d, e ])
        | otherwise = (False, [])
        where 
            (a, b, c, d, e, f, g) = convertTuple $ quickSortKing hand
              
    convertTuple [a, b, c, d, e, f, g] = (a, b, c, d, e, f, g)

    duplicateCheck hand duplicateType pair
        | length ace   == duplicateType && pair /= 01 = (True, ace)
        | length king  == duplicateType && pair /= 00 = (True, king)
        | length queen == duplicateType && pair /= 12 = (True, queen)
        | length jack  == duplicateType && pair /= 11 = (True, jack)
        | length ten   == duplicateType && pair /= 10 = (True, ten)
        | length nine  == duplicateType && pair /= 09 = (True, nine)
        | length eight == duplicateType && pair /= 09 = (True, eight)
        | length seven == duplicateType && pair /= 07 = (True, seven)
        | length six   == duplicateType && pair /= 06 = (True, six)
        | length five  == duplicateType && pair /= 05 = (True, five)
        | length four  == duplicateType && pair /= 04 = (True, four)
        | length three == duplicateType && pair /= 03 = (True, three)
        | length two   == duplicateType && pair /= 02 = (True, two)
        | otherwise = (False, [])
        where
            ace   = [ x | x <- hand, x `mod` 13 == 01 ]
            king  = [ x | x <- hand, x `mod` 13 == 00 ]
            queen = [ x | x <- hand, x `mod` 13 == 12 ]
            jack  = [ x | x <- hand, x `mod` 13 == 11 ]
            ten   = [ x | x <- hand, x `mod` 13 == 10 ]
            nine  = [ x | x <- hand, x `mod` 13 == 09 ]
            eight = [ x | x <- hand, x `mod` 13 == 08 ]
            seven = [ x | x <- hand, x `mod` 13 == 07 ]
            six   = [ x | x <- hand, x `mod` 13 == 06 ]
            five  = [ x | x <- hand, x `mod` 13 == 05 ]
            four  = [ x | x <- hand, x `mod` 13 == 04 ]
            three = [ x | x <- hand, x `mod` 13 == 03 ]
            two   = [ x | x <- hand, x `mod` 13 == 02 ]

    fullHouseCheck hand
        | fst pair && fst triple = (True, concat[ snd pair, snd triple ])
        | otherwise = (False, [])
        where 
            pair   = duplicateCheck hand 2 (-1)
            triple = duplicateCheck hand 3 (-1)

    flushCheck hand
        | length clubs    >= 5 = (True, getFlush $ quickSortRank clubs)
        | length diamonds >= 5 = (True, getFlush $ quickSortRank diamonds)
        | length hearts   >= 5 = (True, getFlush $ quickSortRank hearts)
        | length spades   >= 5 = (True, getFlush $ quickSortRank spades)
        | otherwise = (False, [])
        where 
            clubs    = [ x | x <- hand, x `elem` [01..13] ]
            diamonds = [ x | x <- hand, x `elem` [14..26] ]
            hearts   = [ x | x <- hand, x `elem` [27..39] ]
            spades   = [ x | x <- hand, x `elem` [40..52] ]

    quickSortRank hand
        | head hand `mod` 13 == 0 = quickSortRank (tail hand ++ [ head hand ])
        | head hand `mod` 13 == 1 = quickSortRank (tail hand ++ [ head hand ])
        | otherwise = hand

    getFlush hand
        | length hand > 5 = getFlush (tail hand)
        | otherwise = hand

    straightCheck hand
        | fst d + 1 == fst e && fst d + 2 == fst f && fst d + 3 == fst g && fst d - fst a == fst d - 1 && fst g == 13 = (True, [ snd d, snd e, snd f, snd g, snd a ])
        | fst c + 1 == fst d && fst c + 2 == fst e && fst c + 3 == fst f && fst c - fst a == fst c - 1 && fst f == 13 = (True, [ snd c, snd d, snd e, snd f, snd a ])
        | fst b + 1 == fst c && fst b + 2 == fst d && fst b + 3 == fst e && fst b - fst a == fst b - 1 && fst e == 13 = (True, [ snd b, snd c, snd d, snd e, snd a ])
        | fst c + 1 == fst d && fst c + 2 == fst e && fst c + 3 == fst f && fst c + 4 == fst g                        = (True, [ snd c, snd d, snd e, snd f, snd g ])
        | fst b + 1 == fst c && fst b + 2 == fst d && fst b + 3 == fst e && fst b + 4 == fst f                        = (True, [ snd b, snd c, snd d, snd e, snd f ])
        | fst a + 1 == fst b && fst a + 2 == fst c && fst a + 3 == fst d && fst a + 4 == fst e                        = (True, [ snd a, snd b, snd c, snd d, snd e ])
        | otherwise = (False, [])
        where 
            reducedHand = zip [ if x `mod` 13 == 0 then 13 else x `mod` 13 | x <- (quickSortKing hand) ] (quickSortKing hand)
            noDuplicates = removeDuplicates reducedHand
            (a, b, c, d, e, f, g) = convertTuple $ addEmpty noDuplicates

    quickSortKing hand
        | head hand `mod` 13 == 0 = quickSortKing (tail hand ++ [ head hand ])
        | otherwise = hand

    removeDuplicates [] = []
    removeDuplicates (x:xs) = x:(removeDuplicates (remove x xs))
        where
            remove x [] = []
            remove x (y:ys)
                | fst x == fst y = remove x ys
                | otherwise = y:(remove x ys)

    addEmpty hand
        | length hand < 7 = addEmpty $ hand ++ [(-1, -1)]
        | otherwise = hand

    twoPairCheck hand
        | fst firstPair = (fst secondPair, concat[ snd firstPair, snd secondPair ])
        | otherwise = (False, [])
        where 
            firstPair  = duplicateCheck hand 2 (-1)
            secondPair = duplicateCheck hand 2 ((head $ snd firstPair) `mod` 13)
    
    getHighCard hand = [last $ quickSortRank hand]
    
    kicker value comboOne comboTwo cards
        | (value == 5 || value == 9) = kickerCombo comboOne comboTwo True cards
        | otherwise = kickerCombo comboOne comboTwo False cards
    
    kickerCombo comboOne comboTwo isStraight cards
        | isStraight && (straightComboOne > straightComboTwo) = comboOne
        | isStraight && (straightComboOne < straightComboTwo) = comboTwo
        | not isStraight && (getCardValue reducedComboOne > getCardValue reducedComboTwo) = comboOne
        | not isStraight && (getCardValue reducedComboOne < getCardValue reducedComboTwo) = comboTwo
        | otherwise = kickerWholeHand comboOne comboTwo reducedP1Hand reducedP2Hand
        where
            reducedComboOne = [ if x `mod` 13 == 0 then 13 else x `mod` 13 | x <- comboOne ]
            reducedComboTwo = [ if x `mod` 13 == 0 then 13 else x `mod` 13 | x <- comboTwo ]
            straightComboOne
                | 1 `elem` reducedComboOne && 13 `elem` reducedComboOne = getCardValue reducedComboOne
                | otherwise = sum reducedComboOne
            straightComboTwo
                | 1 `elem` reducedComboTwo && 13 `elem` reducedComboTwo = getCardValue reducedComboTwo
                | otherwise = sum reducedComboTwo
            reducedP1Hand = reverse [ if x `mod` 13 == 0 then 13 else x `mod` 13 | x <- (playerOneHand cards) ]
            reducedP2Hand = reverse [ if x `mod` 13 == 0 then 13 else x `mod` 13 | x <- (playerTwoHand cards) ]

    getCardValue cards
        | length cards > 0 && head cards == 01 = 14 + getCardValue (tail cards)
        | length cards > 0 && head cards /= 01 = head cards + getCardValue (tail cards)
        | otherwise = 0

    kickerWholeHand comboOne comboTwo p1Hand p2Hand
        | length p1Hand > 0 && (head p1Hand > head p2Hand) = comboOne
        | length p1Hand > 0 && (head p1Hand < head p2Hand) = comboTwo
        | length p1Hand > 0 && (head p1Hand == head p2Hand) = kickerWholeHand comboOne comboTwo (tail p1Hand) (tail p2Hand)
        | otherwise = []

-- 160 lines
