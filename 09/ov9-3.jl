# Hammingavstand - antall forskjellige bokstaver på samme plass
#Eksempler:
# Input: s1="AG", s2="AT"
#   Output: 1
# Input: s1="ATG", s2="GTA"
#   Output: 2

function hammingdistance(s1, s2)
    s = length(s1)

    for i = 1:length(s1)
        if s1[i] == s2[i]
            s -= 1
        end
    end

    return s
end