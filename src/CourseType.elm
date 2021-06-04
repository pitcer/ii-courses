module CourseType exposing (CourseType, courseTypes, defaultCourseType, get)

import Dict exposing (Dict)


type alias CourseTypeKey =
    String


type alias CourseType =
    { id : CourseTypeKey
    , name : String
    }


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


courseTypeDict : Dict CourseTypeKey CourseType
courseTypeDict =
    courseTypes
        |> List.map (\courseType -> ( courseType.id, courseType ))
        |> Dict.fromList


get : CourseTypeKey -> Maybe CourseType
get id =
    Dict.get id courseTypeDict
