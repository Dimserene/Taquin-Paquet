--- STEAMODDED HEADER
--- MOD_NAME: Hand Names
--- MOD_ID: HandNames
--- PREFIX: handnames
--- MOD_AUTHOR: [Borb]
--- MOD_DESCRIPTION: Adds flavorful hand names.
--- BADGE_COLOUR: 708b91
--- DEPENDENCIES: []
--- VERSION: 0.0.1

----------------------------------------------
------------MOD CODE -------------------------

old_get_poker_hand_info = G.FUNCS.get_poker_hand_info

poker_hands_with_names = {
    ["High Card"] = {
        ['Even Stevens'] = {2, 4, 6, 8, 10},
        ['Bluff Catcher'] = {11, 4},
        ['What Are The Odds'] = {14, 3, 5, 7, 9},
        ['What Are The Odds'] = {3, 5, 7, 9, 11},
        ['What Are The Odds'] = {5, 7, 9, 11, 13},
        ['All The Primes'] = {2, 3, 5, 7, 11},
        ['All The Primes'] = {3, 5, 7, 11, 13},
        ['AK-47'] = {14, 13, 4, 7},
        ['Star Wars'] = {10, 13, 4, 2, 14},
        ['Rizlo'] = {10, 8, 6, 4, 2},
        ['The Royal Sampler'] = {3, 6, 10, 11, 13},
    },
    ["Pair"] = {
        ['Princess Leia'] = {14, 14, 2, 3},
        ['Austin 3:16'] = {14, 14, 3, 6},
        ['Fibonacci'] = {2, 3, 5, 14, 14},
        ['Fingers \'n\' Toes'] = {10, 10}
    },
    ["Two Pair"] = {
        ['Big Slick Did the Trick'] = {14, 14, 13, 13},
        ['Jackasses'] = {14, 14, 11, 11},
        ['Mommas and Poppas'] = {13, 13, 12, 12},
        ['San Francisco Waiters'] = {12, 12, 3, 3},
        ['Jackson Five'] = {11, 11, 5, 5},
        ['Oldsmobile'] = {9, 9, 8, 8},
        ['Dinner For Four'] = {9, 9, 6, 6},
        ['Rock \'n\' Roll'] = {11, 11, 5, 5},
        ['Hot Waitresses'] = {10, 10, 3, 3},
        ['Socks and Shoes'] = {3, 3, 2, 2},
        ['Dead Man\'s Hand'] = {14, 14, 8, 8},
    },
    ["Three of a Kind"] = {
        ['Athos, Porthos and Aramis'] = {14, 14, 14},
        ['Extra Virgin'] = {9, 9, 9},
        ['Television Subtitles'] = {8, 8, 8},
        ['Slot Machine'] = {7, 7, 7},
        ['The Beast'] = {6, 6, 6},
        ['Pork Chop Sandwich'] = {5, 5, 5},
        ['Grand Jury'] = {4, 4, 4},
        ['The Duck'] = {12, 14, 14, 14, 13},
        ['Huey, Dewey, and Louie'] = {2, 2, 2},
        ["Judas"] = {10, 10, 10},
        ["Hart, Schaffner, and Marx"] = {11, 11, 11},
        ["Daisy Hand"] = {12, 12, 12},
        ["Keane"] = {13, 13, 13},
    },
    ["Straight"] = {
        ['Broadway'] = {14, 13, 12, 11, 10},
        ['Off-Broadway'] = {13, 12, 11, 10, 9},
        ['Convenience Store Straight'] = {11, 10, 9, 8, 7},
        ['Steel Wheel'] = {5, 4, 3, 2, 14},
        ['Sympathy Hand'] = {7, 5, 4, 3, 2},
    },
    ["Flush"] = {
        ['Golden String'] = {10, 11, 14, 14, 10},
    },
    ["Full House"] = {
        ['Tent'] = {2, 2, 2, 3, 3},
        ['Marksman'] = {2, 2, 2, 14, 14},
        ["Windsor Castle"] = {13, 13, 14, 14, 14},
        ["Xnopyt"] = {11, 11, 14, 14, 14}
    },
    ["Four of a Kind"] = {
        ['Knights of the Round Table'] = {14, 14, 14, 14, 13},
        ['Team Rocket'] = {14, 14, 14, 14},
        ['Four Horsemen'] = {13, 13, 13, 13},
        ['Elvis in Vegas'] = {12, 12, 12, 12, 13},
        ['Bachelor\'s Dream'] = {12, 12, 12, 12, 11},
        ['The Strip Club'] = {11, 11, 11, 11, 12},
        ['Neverland Ranch'] = {11, 11, 11, 11, 5},
        ['Larry'] = {10, 10, 10, 10},
        ['Hole-In-One'] = {4, 4, 4, 4, 14},
        ['Forest'] = {3, 3, 3, 3},
        ['Teddy'] = {3, 3, 3, 3, 10},
        ['Mighty Ducks'] = {2, 2, 2, 2},
    },
    ["Straight Flush"] = {
        ['Steel Wheel'] = {5, 4, 3, 2, 14},
        ['Broadway'] = {14, 13, 12, 11, 10},
    }
}

function compare_hands(scoring_hand, expected_ranks)
    if cards_in_hand(scoring_hand) < cards_in_hand(expected_ranks) then
        return false
    end
    table.sort(scoring_hand, function(left, right)
        return left:get_id() < right:get_id()
    end)
    table.sort(expected_ranks)
    for j = 1, cards_in_hand(scoring_hand) do
        sendInfoMessage(expected_ranks[j])
        sendInfoMessage(scoring_hand[j]:get_id())
        if expected_ranks[j] ~= scoring_hand[j]:get_id() then
            return false 
        end
    end
    return true
end
function cards_in_hand(hand)
  local count = 0
  for _ in pairs(hand) do count = count + 1 end
  return count
end

G.FUNCS.get_poker_hand_info = function(_cards)
    local text, loc_disp_text, poker_hands, scoring_hand, disp_text = old_get_poker_hand_info(_cards)
    sendInfoMessage(disp_text)
    if not poker_hands_with_names[disp_text] then
        return text, loc_disp_text, poker_hands, scoring_hand, disp_text
    end
    for hand_name, expected_ranks in pairs(poker_hands_with_names[disp_text]) do
        if compare_hands(scoring_hand, expected_ranks) or compare_hands(_cards, expected_ranks) then
            loc_disp_text = hand_name
            break
        end
    end
    return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end

----------------------------------------------
------------MOD CODE END----------------------
