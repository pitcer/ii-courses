module Main exposing (..)

import Browser
import Course exposing (Course)
import CourseType exposing (CourseType)
import Dict exposing (Dict)
import Html exposing (Html, button, div, input, option, select, table, td, text, th, thead, tr)
import Html.Attributes exposing (name, placeholder, value)
import Html.Events exposing (onClick, onInput)


main : Program () Model Message
main =
    Browser.sandbox { init = init, update = update, view = view }


type Message
    = CourseIdInput String
    | CourseNameInput String
    | CourseEctsInput String
    | CourseTypeSelected String
    | CourseRemove String
    | AddCourse


type alias Model =
    { courses : Dict String Course
    , courseId : String
    , courseName : String
    , courseEcts : Int
    , courseType : CourseType
    }


init : Model
init =
    { courses = Dict.empty
    , courseId = ""
    , courseName = ""
    , courseEcts = 0
    , courseType = CourseType.defaultCourseType
    }


update : Message -> Model -> Model
update message model =
    case message of
        CourseIdInput id ->
            { model | courseId = id }

        CourseNameInput name ->
            { model | courseName = name }

        CourseEctsInput ects ->
            { model | courseEcts = Maybe.withDefault 0 (String.toInt ects) }

        CourseTypeSelected courseTypeString ->
            let
                courseType =
                    Maybe.withDefault
                        CourseType.defaultCourseType
                        (CourseType.get courseTypeString)
            in
            { model | courseType = courseType }

        AddCourse ->
            let
                course : Course
                course =
                    { id = model.courseId
                    , name = model.courseName
                    , ects = model.courseEcts
                    , courseType = model.courseType
                    , effects = []
                    }
            in
            { model | courses = Dict.insert model.courseId course model.courses }

        CourseRemove courseId ->
            { model | courses = Dict.remove courseId model.courses }


view : Model -> Html Message
view model =
    let
        courseTableHeader : Html Message
        courseTableHeader =
            thead []
                [ th [] [ text "ID" ]
                , th [] [ text "Nazwa" ]
                , th [] [ text "ECTS" ]
                , th [] [ text "Typ" ]
                , th [] [ text "Efekty" ]
                , th [] []
                ]

        courseTableRemoveButton : Course -> Html Message
        courseTableRemoveButton course =
            button [ onClick (CourseRemove course.id) ]
                [ text "Usuń" ]

        courseToTableRow : Course -> Html Message
        courseToTableRow course =
            tr []
                [ td [] [ text course.id ]
                , td [] [ text course.name ]
                , td [] [ text (String.fromInt course.ects) ]
                , td [] [ text course.courseType.name ]
                , td [] [ text (Course.effectsToString course.effects) ]
                , td [] [ courseTableRemoveButton course ]
                ]

        courseTable : Html Message
        courseTable =
            table []
                (courseTableHeader :: List.map courseToTableRow (Dict.values model.courses))

        courseTypeToOption : CourseType -> Html Message
        courseTypeToOption courseType =
            option [ value courseType.id ]
                [ text courseType.name ]

        courseTypeSelection : Html Message
        courseTypeSelection =
            select [ name "Typ", onInput CourseTypeSelected ]
                (List.map courseTypeToOption CourseType.courseTypes)
    in
    div []
        [ div []
            [ input [ placeholder "ID", value model.courseId, onInput CourseIdInput ] []
            , input [ placeholder "Nazwa", value model.courseName, onInput CourseNameInput ] []
            , input [ placeholder "ECTS", value (String.fromInt model.courseEcts), onInput CourseEctsInput ] []
            , courseTypeSelection
            , button [ onClick AddCourse ] [ text "Dodaj przedmiot" ]
            ]
        , courseTable
        ]
