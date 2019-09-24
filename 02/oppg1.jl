# Oving 2 oppg 1
#=
Du skal lære å traversere (se på alle elementene) i en lenket liste. Det viktige i denne øvingen er å forstå hvordan elementer kan være lenket sammen ved hjelp av referanser. Dette er veldig vanlig i objektorientert programmering. Trikset når du lager en lenket liste, er å koble sammen flere objekter av samme klasse, slik at hvert objekt har en referanse (lenke) til ett annet objekt (det 'neste' objektet'). Hvis du så et eller annet sted tar vare på en referanse til det første objektet i lenkingen. har du et utgangspunkt for å traverse hele listen av objekter.

Du skal lage en funksjon som tar imot en lenket liste og en indeks. Denne funksjonen skal så traversere lista og returnerer tallet som er i plassen til indeks argumentet. Funksjonen skal hete findindexinlist, og den skal kunne ta to argumenter Det første argumentet er hodet (den første noden) i en lenka liste av typen Node. Node har to felter: value, som er tallet som objektet lagrer, og next, som er det neste Node-objektet i listen. Det siste Node-objektet i listen vil ha node.next-verdien lik nothing (samme som null i Java eller None i Python).

I julia kan du hente feltene ut fra objektet med å bruke node.value og node.next gitt at objektet heter node.

Det andre argumentet er et heltall som forteller hvilket element i listen verdien skal komme fra.

Hvis indeksen er større enn lengden til den lenka listen skal du returnere -1.

Typen Node og den lenkede listen blir lagd for deg; det trenger du ikke å gjøre. Men for å teste på din egen maskin kan det være nyttig å vite hvordan det blir gjort:
=#

#= 
    KRAV:
        findindexinlist skal
            returnere -1 hvis len(liste) > indeks
            returnere den første indeksen med verdien ellers
=# 

# Utdelt kode
mutable struct Node
    next::Union{Node, Nothing} # next kan peke på et Node-objekt eller ha verdien nothing.
    value::Int
end

function createlinkedlist(length)
    # Creates the list starting from the last element
    # This is done so the last element we generate is the head
    child = nothing
    node = nothing

    for i in 1:length
        node = Node(child, rand(1:800))
        child = node
    end
    return node
end

# Besvarelse
function findindexinlist(linkedlist, index)
    current_idx = 1
    current_node = linkedlist    
    
    while (current_idx < index)
        current_node = current_node.next
        if current_node == nothing
            return -1
        end
        current_idx += 1
    end

    return current_node.value
end