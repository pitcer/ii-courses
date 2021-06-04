module CourseEffect exposing (CourseEffect, Key, courseEffects, get)

import Dict exposing (Dict)


type alias Key =
    String


type alias CourseEffect =
    { id : Key
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


courseEffectsDict : Dict Key CourseEffect
courseEffectsDict =
    courseEffects
        |> List.map (\effect -> ( effect.id, effect ))
        |> Dict.fromList


get : Key -> Maybe CourseEffect
get id =
    Dict.get id courseEffectsDict
