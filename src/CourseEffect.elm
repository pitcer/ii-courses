module CourseEffect exposing (CourseEffect(..), courseEffects, find, getId, getName)


type CourseEffect
    = CourseEffect String String


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


getId : CourseEffect -> String
getId courseEffect =
    case courseEffect of
        CourseEffect id _ ->
            id


getName : CourseEffect -> String
getName courseEffect =
    case courseEffect of
        CourseEffect _ name ->
            name


find : String -> Maybe CourseEffect
find id =
    courseEffects |> List.filter (\element -> getId element == id) |> List.head
