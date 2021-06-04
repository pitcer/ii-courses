module Course exposing (Course, effectsToString)

import CourseEffect exposing (CourseEffect)
import CourseType exposing (CourseType)


type alias Course =
    { id : String
    , name : String
    , ects : Int
    , courseType : CourseType
    , effects : List CourseEffect
    }


effectsToString : List CourseEffect -> String
effectsToString effects =
    if List.isEmpty effects then
        "Brak"

    else
        effects |> List.map .name |> String.join ", "
