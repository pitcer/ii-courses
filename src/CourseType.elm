module CourseType exposing (CourseType, courseTypes, find, getId, getName, defaultCourseType)


type CourseType
    = CourseType String String


defaultCourseType : CourseType
defaultCourseType =
    CourseType "Other" "Inny"


courseTypes : List CourseType
courseTypes =
    [ CourseType "I1" "Informatyczny 1"
    , CourseType "I2" "Informatyczny 2"
    , CourseType "IInz" "Informatyczny inżynierski"
    , CourseType "I2T" "Informatyczny 2 - teoria informatyki"
    , CourseType "I2Z" "Informatyczny 2 - zastosowania informatyki"
    , CourseType "K1" "Kurs podstawowy"
    , CourseType "K2" "Kurs zaawanowany"
    , CourseType "KInz" "Kurs inżynierski"
    , CourseType "O1" "Obowiązkowy 1"
    , CourseType "O2" "Obowiązkowy 2"
    , CourseType "O3" "Obowiązkowy 3"
    , CourseType "P" "Projekt"
    , CourseType "S" "Seminarium"
    , CourseType "PS" "Proseminarium"
    , CourseType "WF" "Wychowanie fizyczne"
    , CourseType "L" "Lektorat"
    , CourseType "HS" "Humanistyczno-społeczny"
    , defaultCourseType
    ]


getId : CourseType -> String
getId courseType =
    case courseType of
        CourseType id _ ->
            id


getName : CourseType -> String
getName courseType =
    case courseType of
        CourseType _ name ->
            name


find : String -> Maybe CourseType
find id =
    courseTypes |> List.filter (\element -> (getId element) == id) |> List.head
