// Tran Kelvin Lim (500769478)
// Section 01
// 
// Section 

struct Player {
    hand:  [u32; 7],
    value: u32,
    combo: [usize; 5],
}

fn buildPlayer(pHand: [u32; 7]) -> Player {
    Player {
        hand: pHand,
        value: 0,
        combo: [0, 0, 0, 0, 0],
    }
}

fn sortHand(mut player: Player) -> Player {
    let mut sorted: [u32; 7] = [0, 0, 0, 0, 0, 0, 0];
    let mut index: usize = 0;
    let order: [u32; 13] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 0];

    // Sorts the hand with ace low to king
    for &value in order.iter() {
        for &card in player.hand.iter() {
            if card % 13 == value { 
                sorted[index] = card; 
                index += 1;
            }
        }
    }

    // Sets the player hand to the sorted hand
    for index in 0..player.hand.len() {
        player.hand[index] = sorted[index];
    }

    player
}

fn evaluateHand(mut player: Player) -> Player {
    if player.value == 0 { player = royalFlushCheck(player); }
    if player.value == 0 { player = straightFlushCheck(player); }
    if player.value == 0 { player = fourOfAKindCheck(player); }
    if player.value == 0 { player = fullHouseCheck(player); }
    if player.value == 0 { player = flushCheck(player); }
    if player.value == 0 { player = straightCheck(player); }
    if player.value == 0 { player = tripleCheck(player); }
    if player.value == 0 { player = twoPairCheck(player); }
    if player.value == 0 { player = pairCheck(player); }
    if player.value == 0 { player = getHighestCard(player); }
    player
}

fn royalFlushCheck(mut player: Player) -> Player {
    let royal_flush_combos = [[1, 10, 11, 12, 13], [14, 23, 24, 25, 26], [27, 36, 37, 38, 39], [40, 49, 50, 51, 52]];
    
    // Loop through each royal flush combo possibility
    for index in 0..royal_flush_combos.len() {
        let mut royal_flush_exists = true;
        let current_combo = royal_flush_combos[index];

        // Determines if a royal flush exists
        for card in current_combo.iter() {
            if !player.hand.contains(card) { royal_flush_exists = false; }
        }

        // If it does exist, set the combo to the corresponding royal flush combo
        if royal_flush_exists { 
            for combo_index in 0..current_combo.len() {
                player.combo[combo_index] = current_combo[combo_index] as usize;
            }
            player.value = 10;
        }
    }

    player
}

fn straightFlushCheck(mut player: Player) -> Player {
    for index in 0..player.hand.len() - 4 {
        let card = player.hand[index];
        let mut comboExists = true;

        for next in 1..5 {
            if !player.hand.contains(&(card + next as u32)) {
                comboExists = false;
            }
        }

        if comboExists {
            for handIndex in 0..player.combo.len() {
                player.combo[handIndex] = (card + handIndex as u32) as usize;
            }
            player.value = 9;
        }
    }

    player
}

fn fourOfAKindCheck(mut player: Player) -> Player {
    let order: [u32; 13] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 0, 1];

    for &value in order.iter() {
        let mut duplicateCount = 0;

        for card in player.hand.iter() {
            if card % 13 == value { duplicateCount += 1; }
        }

        if duplicateCount == 4 {
            let mut index = 0;
            for card in player.hand.iter() {
                if card % 13 == value { 
                    player.combo[index] = *card as usize;
                    index += 1;
                }
            }
            player.value = 8;
        }
    }

    player
}

fn fullHouseCheck(mut player: Player) -> Player {
    let order: [u32; 13] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 0, 1];

    let mut triple = 15;
    let mut pair = 15;

    for &value in order.iter().rev() {
        let mut duplicateCount = 0;

        for card in player.hand.iter() {
            if card % 13 == value { duplicateCount += 1; }
        }

        if duplicateCount == 3 {
            triple = value;
        }
        if duplicateCount == 2 {
            pair = value;
        }
    }

    if triple != 15 && pair != 15 {
        let mut index = 0;
        for card in player.hand.iter() {
            if card % 13 == triple || card % 13 == pair { 
                player.combo[index] = *card as usize; 
                index += 1;
            }
        }
        player.value = 7;
    }

    player
}

fn flushCheck(mut player: Player) -> Player {
    let suits: [[u32; 2]; 4] = [[1, 13], [14, 26], [27, 39], [40, 52]];

    for suit in suits.iter() {
        let leftLimit = suit[0];
        let rightLimit = suit[1];
        let mut suitCount = 0;

        for &card in player.hand.iter() {
            if card >= leftLimit && card <= rightLimit { suitCount += 1; }
        }

        if suitCount >= 5 { 
            let mut index = 0;

            for &card in player.hand.iter().rev() {
                if card >= leftLimit && card <= rightLimit { 
                    if index >= 5 {
                        if card % 13 == 1 { player.combo[player.combo.len() - 1] = card as usize; }
                    }
                    else { 
                        player.combo[index] = card as usize;
                        index += 1;
                    }
                }
            }

            player.value = 6;
        }
    }

    player
}

fn straightCheck(mut player: Player) -> Player {
    let mut reducedHand: [u32; 7] = [0, 0, 0, 0, 0, 0, 0];
    
    let mut reducedIndex = 0;
    for &card in player.hand.iter() {
        reducedHand[reducedIndex] = card % 13;
        reducedIndex += 1;
    }

    for currentIndex in 0..reducedHand.len() - 4 {
        let card = reducedHand[currentIndex];
        let mut comboExists = true;

        for next in 1..5 {
            let checkCard = (card + next as u32) % 13;
            if !reducedHand.contains(&checkCard) {
                comboExists = false;
            }
        }

        if comboExists {
            for handIndex in 0..player.combo.len() {
                for &playerCard in player.hand.iter() {
                    if playerCard % 13 == reducedHand[currentIndex + handIndex] {
                        player.combo[handIndex] = playerCard as usize;
                        break;
                    }
                }
            }

            player.value = 5;
        }
    }

    player
}

fn tripleCheck(mut player: Player) -> Player {
    let order: [u32; 13] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 0, 1];

    for &value in order.iter() {
        let mut duplicateCount = 0;

        for card in player.hand.iter() {
            if card % 13 == value { duplicateCount += 1; }
        }

        if duplicateCount == 3 {
            let mut index = 0;
            for card in player.hand.iter() {
                if card % 13 == value { 
                    player.combo[index] = *card as usize;
                    index += 1;
                }
            }

            player.value = 4;
        }
    }

    player
}

fn twoPairCheck(mut player: Player) -> Player {
    let order: [u32; 13] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 0, 1];

    let mut pairOne = 15;
    let mut pairTwo = 15;

    for &value in order.iter() {
        let mut duplicateCount = 0;

        for &card in player.hand.iter() {
            if card % 13 == value { duplicateCount += 1; }
        }

        if duplicateCount == 2 {
            pairOne = value;
        }
    }

    for &value in order.iter() {
        let mut duplicateCount = 0;

        for &card in player.hand.iter() {
            if card % 13 == value { duplicateCount += 1; }
        }

        if duplicateCount == 2 && pairOne != value {
            pairTwo = value;
        }
    }

    if pairOne != 15 && pairTwo != 15 {
        let mut index = 0;

        for &card in player.hand.iter() {
            if card % 13 == pairOne || card % 13 == pairTwo { 
                player.combo[index] = card as usize;
                index += 1;
            }
        }

        player.value = 3;
    }

    player
}

fn pairCheck(mut player: Player) -> Player {
    let order: [u32; 13] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 0, 1];

    for &value in order.iter() {
        let mut duplicateCount = 0;

        for card in player.hand.iter() {
            if card % 13 == value { duplicateCount += 1; }
        }

        if duplicateCount == 2 {
            let mut index = 0;
            for card in player.hand.iter() {
                if card % 13 == value { 
                    player.combo[index] = *card as usize;
                    index += 1;
                }
            }

            player.value = 2;
        }
    }

    player
}

fn getHighestCard(mut player: Player) -> Player {
    if player.hand[0] % 13 == 1 { player.combo[0] = player.hand[0] as usize; }
    else { player.combo[player.combo.len() - 1] = player.hand[player.hand.len() - 1] as usize; }
    player.value = 1;
    player
}

fn determineWinner(cards: [u32; 9]) -> [usize; 5] {
    let mut playerOneHand = buildPlayer([cards[0], cards[2], cards[4], cards[5], cards[6], cards[7], cards[8]]);
    let mut playerTwoHand = buildPlayer([cards[1], cards[3], cards[4], cards[5], cards[6], cards[7], cards[8]]);

    playerOneHand = sortHand(playerOneHand);
    playerTwoHand = sortHand(playerTwoHand);

    playerOneHand = evaluateHand(playerOneHand);
    playerTwoHand = evaluateHand(playerTwoHand);

    // println!("{:?} {} {:?}", playerOneHand.hand, playerOneHand.value, playerOneHand.combo);
    // println!("{:?} {} {:?}", playerTwoHand.hand, playerTwoHand.value, playerTwoHand.combo);

    if playerOneHand.value > playerTwoHand.value { playerOneHand.combo }
    else if playerOneHand.value < playerTwoHand.value { playerTwoHand.combo }
    else { kicker(playerOneHand, playerTwoHand) }
}

fn kicker(playerOne: Player, playerTwo: Player) -> [usize; 5] {
    if playerOne.value == 5 || playerOne.value == 9 { 
        kickerStraight(playerOne, playerTwo) 
    }
    else {
        kickerCombo(playerOne, playerTwo)
    }
}

fn kickerStraight(playerOne: Player, playerTwo: Player) -> [usize; 5] {
    if playerOne.value == 9 {
        let mut playerOneComboSum = 0;
        let mut playerTwoComboSum = 0;

        for &card in playerOne.combo.iter() {
            if &card % 13 == 0 { playerOneComboSum += 13; }
            else { playerOneComboSum += &card % 13; }
        }

        for &card in playerTwo.combo.iter() {
            if &card % 13 == 0 { playerTwoComboSum += 13; }
            else { playerTwoComboSum += &card % 13; }
        }

        if playerOneComboSum > playerTwoComboSum { playerOne.combo }
        else if playerOneComboSum < playerTwoComboSum { playerTwo.combo }
        else { kickerWholeHand(playerOne, playerTwo) }
    }

    else {
        let mut playerOneComboSum = 0;
        let mut playerTwoComboSum = 0;

        let mut reducedHandOne: [u32; 7] = [0, 0, 0, 0, 0, 0, 0];
        let mut reducedHandTwo: [u32; 7] = [0, 0, 0, 0, 0, 0, 0];
    
        let mut reducedIndex = 0;
        for &card in playerOne.combo.iter() {
            reducedHandOne[reducedIndex] = card as u32 % 13;
            reducedIndex += 1;
        }

        let mut reducedIndex = 0;
        for &card in playerTwo.combo.iter() {
            reducedHandTwo[reducedIndex] = card as u32 % 13;
            reducedIndex += 1;
        }

        if reducedHandOne.contains(&1) && reducedHandOne.contains(&0) {
            for &card in playerOne.combo.iter() {
                if &card % 13 == 0 { playerOneComboSum += 13; }
                else if &card % 13 == 1 { playerOneComboSum += 14; }
                else { playerOneComboSum += &card % 13; }
            }
        }
        else {
            for &card in playerOne.combo.iter() {
                if &card % 13 == 0 { playerOneComboSum += 13; }
                else { playerOneComboSum += &card % 13; }
            }
        }

        if reducedHandTwo.contains(&1) && reducedHandTwo.contains(&0) {
            for &card in playerTwo.combo.iter() {
                if &card % 13 == 0 { playerTwoComboSum += 13; }
                else if &card % 13 == 1 { playerTwoComboSum += 14; }
                else { playerTwoComboSum += &card % 13; }
            }
        }
        else {
            for &card in playerTwo.combo.iter() {
                if &card % 13 == 0 { playerTwoComboSum += 13; }
                else { playerTwoComboSum += &card % 13; }
            }
        }

        if playerOneComboSum > playerTwoComboSum { playerOne.combo }
        else if playerOneComboSum < playerTwoComboSum { playerTwo.combo }
        else { kickerWholeHand(playerOne, playerTwo) }
    }
}

fn kickerCombo(playerOne: Player, playerTwo: Player) -> [usize; 5] {
    let mut playerOneComboSum = 0;
    let mut playerTwoComboSum = 0;

    for &card in playerOne.combo.iter() {
        if &card % 13 == 0 { playerOneComboSum += 13; }
        else if &card % 13 == 1 { playerOneComboSum += 14; }
        else { playerOneComboSum += &card % 13; }
    }

    for &card in playerTwo.combo.iter() {
        if &card % 13 == 0 { playerTwoComboSum += 13; }
        else if &card % 13 == 1 { playerTwoComboSum += 14; }
        else { playerTwoComboSum += &card % 13; }
    }

    if playerOneComboSum > playerTwoComboSum { playerOne.combo }
    else if playerOneComboSum < playerTwoComboSum { playerTwo.combo }
    else { kickerWholeHand(playerOne, playerTwo) }
}

fn kickerWholeHand(mut playerOne: Player, mut playerTwo: Player) -> [usize; 5] {
    playerOne = sortRank(playerOne);
    playerTwo = sortRank(playerTwo);

    let mut winningCombo = 0;

    for index in 0..playerOne.hand.len() {
        if playerOne.hand[index] > playerTwo.hand[index] { winningCombo = 1; break;}
        else if playerOne.hand[index] < playerTwo.hand[index] { winningCombo = 2; break; }
        else { winningCombo = 0; }
    }

    if winningCombo == 1 { playerOne.combo }
    else { playerTwo.combo }
}

fn sortRank(mut player: Player) -> Player {
    let mut sorted: [u32; 7] = [0, 0, 0, 0, 0, 0, 0];
    let mut index: usize = 0;
    let order: [u32; 13] = [1, 0, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2];

    // Sorts the hand with ace low to king
    for &value in order.iter() {
        for &card in player.hand.iter() {
            if card % 13 == value { 
                sorted[index] = card; 
                index += 1;
            }
        }
    }

    // Sets the player hand to the sorted hand
    for index in 0..player.hand.len() {
        player.hand[index] = sorted[index];
    }

    player
}

fn convertCombo(winnning_combo: [usize; 5]) -> Vec<String> {
    let card_values = [ "empty", 
            "1C", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "11C", "12C", "13C", 
            "1D", "2D", "3D", "4D", "5D", "6D", "7D", "8D", "9D", "10D", "11D", "12D", "13D", 
            "1H", "2H", "3H", "4H", "5H", "6H", "7H", "8H", "9H", "10H", "11H", "12H", "13H", 
            "1S", "2S", "3S", "4S", "5S", "6S", "7S", "8S", "9S", "10S", "11S", "12S", "13S" ];
    
    let mut string_combo: Vec<String> = Vec::new();

    for &index in winnning_combo.iter() {
        if index != 0 {
            string_combo.push(String::from(card_values[index]));
        }
    }

    string_combo
}

pub fn deal(cards: [u32; 9]) -> Vec<String> {
    let winner = determineWinner(cards);
    convertCombo(winner)
}

// 410 lines
