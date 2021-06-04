module CourseEffect exposing (courseEffects, get, CourseEffect)

import Dict exposing (Dict)


type alias CourseEffectKey =
    String


type alias CourseEffect =
    { id : CourseEffectKey
    , name : String
    }


courseEffects : List CourseEffect
courseEffects =
    [ CourseEffect "RPL" "Rachunek Prawdopodobieństwa (L)"
    , CourseEffect "RPI" "Rachunek Prawdopodobieństwa (I)"
    , CourseEffect "IO" "Inżynieria Oprogramowania"
    , CourseEffect "PiPO" "Programowanie i Projektowanie oprogramowania"
    , CourseEffect "ASK" "Architektury Systemów Komputerowych"
    , CourseEffect "SO" "Systemy Operacyjne"
    , CourseEffect "SK" "Sieci Komputerowe"
    , CourseEffect "BD" "Bazy Danych"
    , CourseEffect "OWI" "Ochrona Własności Intelektualnej"
    , CourseEffect "E" "Ekonomia"
    ]


courseEffectsDict : Dict CourseEffectKey CourseEffect
courseEffectsDict =
    courseEffects
        |> List.map (\effect -> ( effect.id, effect ))
        |> Dict.fromList


get : CourseEffectKey -> Maybe CourseEffect
get key =
    Dict.get key courseEffectsDict
