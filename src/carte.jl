
module CardDefinitions

using Random
const suits = ["clubs","spades","hearts","diamonds"]
const ranks = ["ace","2","3","4","5","6","7","8","9","10","jack","queen","king"]

const dico_card_value = Dict(
    "ace" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "10" => 10,
    "jack" => 10,
    "queen" => 10,
    "king" => 10
)

#Old code
struct Card
    suit::String
    rank::String

end

"""
Fonction de renvoie de la valeur numérique d'une Card c.
"""
function value(c::Card)
    return dico_card_value[c.rank]
end

export Card, value, suits, ranks, dico_card_value

end


