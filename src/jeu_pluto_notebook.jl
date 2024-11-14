include("carte.jl")
using .CardDefinitions
include("deck.jl")
using .DeckDefinitions
# import Pluto; Pluto.run()

mutable struct Game
    blackjack_deck::Deck
    player_hand::Deck
    dealer_hand::Deck
    end_game::Bool
end

"""
Fonction d'initialisation du jeu : renvoie une game
"""
function initialize_game()
    # Instancier un deck de black jack
    blackjack_deck = DeckDefinitions.create_blackjack_deck(6)
    # Le melanger
    shuffle!(blackjack_deck)
    
    # Instancier une main pour le dealer et le joueur
    player_hand = create_empty_hand()
    dealer_hand = create_empty_hand()

    # Distribution des cartes
    take_a_card(blackjack_deck,player_hand)
    take_a_card(blackjack_deck,dealer_hand)
    take_a_card(blackjack_deck,player_hand)

    return Game(blackjack_deck,player_hand,dealer_hand,false)
end

"""
Fonction pour remettre à 0 une game passée en argument.
"""
function new!(game::Game)
    # Instancier un deck de black jack
    blackjack_deck = DeckDefinitions.create_blackjack_deck(6)
    # Le melanger
    shuffle!(blackjack_deck)
    
    # Instancier une main pour le dealer et le joueur
    player_hand = create_empty_hand()
    dealer_hand = create_empty_hand()

    # Distribution des cartes
    take_a_card(blackjack_deck,player_hand)
    take_a_card(blackjack_deck,dealer_hand)
    take_a_card(blackjack_deck,player_hand)

    # On modifie le game passé en argument
    game.blackjack_deck = blackjack_deck
    game.player_hand = player_hand
    game.dealer_hand = dealer_hand
    game.end_game = false
end

function end_game!(game::Game)
    game.end_game = hand_value(game.player_hand) >=21
end

function turn!(game,player_action)
    if !game.end_game
        if(player_action=="hit")
            take_a_card(game.blackjack_deck,game.player_hand)
            end_game!(game)
        end
        elseif (player_action == "stand")
            hand_value_dealer = hand_value(dealer_hand)
            while (hand_value_dealer < 17)
                take_a_card(game.blackjack_deck,game.dealer_hand)
                hand_value_dealer = hand_value(dealer_hand)
            end
            game.end_game = true
        end    
end

function Vizagrams.draw(game::Game)
    text_player_hand = "The player's hand :\n"
    for card in game.player_hand.cards
        text_player_hand = text_player_hand * "$card.rank of $card.suit, "
    end
    text_dealer_hand = "The dealer's hand :\n"
    for card in game.dealer_hand.cards
        text_dealer_hand = text_dealer_hand * "$card.rank of $card.suit, "
    end
    text_end_game = ""
    if(game.end_game)
        if ((hand_value_player <= 21) && ((hand_value_dealer < hand_value_player) || hand_value_dealer > 21))
            text_end_game = "You won !"
        elseif (hand_value_player>21)
            text_end_game = "You went over 21, you lost."
        elseif ((hand_value_dealer <= 21) && (hand_value_dealer > hand_value_player))
            text_end_game = "The dealer won."
        else
            text_end_game = "Draw."
         end
    else
        text_end_game = "Choose an action!"
    end

    full_text = text_player_hand * "\n" * text_dealer_hand * "\n" * text_end_game
    d = TextMark(full_text, fontsize=11)
    return draw(d, height=100)
end

function interaction()
    d = S(:fill=>:blue)*(S(:__id => :circ)T(3,0)Circle() + S(:__id => :tri)T(0,2)RegularPolygon(n=3) +
    S(:__id => :sq)R(π/10)U(2)Square()) +
    T(2,-2)S(:stroke=>:red,:strokeWidth=>5)Line([[0,0],[3,0],[3,3]])
 	return draw(d, height=400; :id => :graph)
end


