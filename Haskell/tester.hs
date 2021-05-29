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