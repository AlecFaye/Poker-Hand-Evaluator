| cards perms sols totalScore totalTests |

cards := #(	'1C' '2C' '3C' '4C' '5C' '6C' '7C' '8C' '9C' '10C' '11C' '12C' '13C'
			'1D' '2D' '3D' '4D' '5D' '6D' '7D' '8D' '9D' '10D' '11D' '12D' '13D'
			'1H' '2H' '3H' '4H' '5H' '6H' '7H' '8H' '9H' '10H' '11H' '12H' '13H'
			'1S' '2S' '3S' '4S' '5S' '6S' '7S' '8S' '9S' '10S' '11S' '12S' '13S'
		  ).

perms := #( #( 9  8  7  6  5  4  3  2  1  )    "1   2-6 straight flush VS 1-5 straight flush"
            #( 40 41 42 43 48 49 50 51 52 )    "2   Royal flush VS straight flush"
            #( 40 41 27 28 1  14 15 42 29 )    "3   Four aces VS 2-full-of-A"
            #( 30 13 27 44 12 17 33 41 43 )    "4   3-fours VS 2-fours"
            #( 27 45 3  48 44 43 41 33 12 )    "5   Flush VS straight"
            #( 17 31 30 51 44 43 41 33 12 )    "6   3-fours VS 2-queens-2-fives"
            #( 17 39 30 52 44 25 41 51 12 )    "7   Q-full-of-K VS Q-full-of-4"
            #( 11 25 9  39 50 48 3  49 45 )    "8   9-K straight VS 9-J-two-pair"
            #( 50 26 39 3  11 27 20 48 52 )    "9   J-K-two-pair VS K-pair"
            #( 40 52 46 11 48 27 29 32 37 )    "10  A-pair VS J-pair"
          ). 
               
sols :=  #( #( '2C'  '3C'  '4C'  '5C'  '6C'  ) "1   2-6 straight flush"
            #( '10S' '11S' '12S' '13S' '1S'  ) "2   Royal flush"
            #( '1C'  '1D'  '1H'  '1S'        ) "3   Four aces"
            #( '4D'  '4H'  '4S'              ) "4   3-fours"
            #( '2S'  '4S'  '5S'  '6S'  '9S'  ) "5   Flush"
            #( '4D'  '4H'  '4S'              ) "6   3-fours"
            #( '12C' '12D' '12S' '13H' '13S' ) "7   Q-full-of-K"
            #( '10S' '11S' '12D' '13H' '9S'  ) "8   9-K straight"
            #( '11C' '11S' '13H' '13S'       ) "9   J-K-two-pair"
            #( '1H'  '1S'                    ) "10  A-pair"
          ).

totalScore := 0.
totalTests := 0.

Transcript clear.
1 to: 10 do: [ :test | 
	| poker input deal youSaid shouldBe ex |
	input    := (perms at: test).
 	shouldBe := (sols at: test).
    deal     := OrderedCollection new.
    input do: [ :id | deal add: (cards at: id) ].
    
    ex := false.
	[ poker := Poker new. youSaid := (poker deal: input) ] on: Exception do: [ :e | 
		Transcript show: 'Exception on input:'; cr; show: input; cr.
		Transcript show: e description; cr; show: 'SKIPPING...'; cr.
		ex := true.
    ].
    ex ifFalse: [
    	| score |
      	score := 0.
		shouldBe do: [ :elem | (youSaid includes: elem) ifTrue: [ score := score + 1 ] ].
        (score = shouldBe size) 
        ifTrue:  [ 
            Transcript show: 'Test '; show: test; show: ' FULL MARKS  '.
			Transcript show: '('; show: score; show: ' of '; show: (shouldBe size); show: ' cards correct)'; cr. 
        ]
        ifFalse: [ 
			Transcript show: 'Test '; show: test; show: ' DISCREPANCY: '; show: input; cr.	
			Transcript show: '  P1:   '; show: (deal at: 1), ',', (deal at: 3); cr.
			Transcript show: '  P2:   '; show: (deal at: 2), ',', (deal at: 4); cr.
			Transcript show: '  Pool: '; show: (deal at: 5), ',', (deal at: 6), ',', (deal at: 7), ',', (deal at: 8), ',', (deal at: 9); cr.
  			Transcript show: '  You returned:   '; show: youSaid; cr.	
         	Transcript show: '  Should contain: '; show: shouldBe; cr.
        	Transcript show: '  '; show: score; show: ' of '; show: (shouldBe size); show: ' cards correct'; cr.                				
		].
		totalScore := totalScore + (score / shouldBe size).
    ].
	totalTests := totalTests + 1.
].

Transcript cr; show: 'Total score: '; show: (100 * totalScore / totalTests) asFloat; show: '%  ('.
Transcript show: totalScore asFloat; show: '/'; show: totalTests asFloat; show: ' points)'; cr.
