module Main exposing (..)

import Browser
import Browser.Events exposing (Visibility(..))
import Course exposing (Course)
import CourseEffect exposing (CourseEffect)
import CourseType exposing (CourseType)
import Dict exposing (Dict)
import Html exposing (Html, button, div, input, option, select, table, td, text, th, thead, tr)
import Html.Attributes exposing (disabled, hidden, name, placeholder, selected, value)
import Html.Events exposing (onClick, onInput)


main : Program () Model Message
main =
    Browser.sandbox { init = init, update = update, view = view }


type Message
    = CourseIdInput String
    | CourseNameInput String
    | CourseEctsInput String
    | CourseTypeSelected String
    | CourseEffectSelected String
    | CourseRemove String
    | EffectRemove CourseEffect.Key
    | AddEffect
    | AddCourse


type alias Model =
    { courses : Dict String Course
    , courseId : String
    , courseName : String
    , courseEcts : Int
    , courseType : CourseType
    , selectedEffect : Maybe CourseEffect
    , courseEffects : Dict CourseEffect.Key CourseEffect
    }


init : Model
init =
    { courses = Dict.empty
    , courseId = ""
    , courseName = ""
    , courseEcts = 0
    , courseType = CourseType.defaultCourseType
    , selectedEffect = Nothing
    , courseEffects = Dict.empty
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

        CourseEffectSelected effectString ->
            { model | selectedEffect = CourseEffect.get effectString }

        AddEffect ->
            case model.selectedEffect of
                Just effect ->
                    { model | courseEffects = Dict.insert effect.id effect model.courseEffects }

                Nothing ->
                    model

        AddCourse ->
            let
                course : Course
                course =
                    { id = model.courseId
                    , name = model.courseName
                    , ects = model.courseEcts
                    , courseType = model.courseType
                    , effects = Dict.values model.courseEffects
                    }
            in
            { model | courses = Dict.insert model.courseId course model.courses }

        CourseRemove courseId ->
            { model | courses = Dict.remove courseId model.courses }

        EffectRemove effectId ->
            { model | courseEffects = Dict.remove effectId model.courseEffects }


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
                (selectionPlaceholder "---" :: List.map courseTypeToOption CourseType.courseTypes)

        courseEffectToOption : CourseEffect -> Html Message
        courseEffectToOption effect =
            option [ value effect.id ]
                [ text effect.name ]

        selectionPlaceholder : String -> Html Message
        selectionPlaceholder content =
            option [ value "", selected True, disabled True, hidden True ]
                [ text content ]

        courseEffectSelection : Html Message
        courseEffectSelection =
            select [ name "Efekt", onInput CourseEffectSelected ]
                (selectionPlaceholder "---" :: List.map courseEffectToOption CourseEffect.courseEffects)

        courseEffectsList : Html Message
        courseEffectsList =
            div []
                (let
                    effects : List CourseEffect
                    effects =
                        Dict.values model.courseEffects

                    effectToDivWithDeletion : CourseEffect -> Html Message
                    effectToDivWithDeletion effect =
                        div []
                            [ text effect.name
                            , button [ onClick (EffectRemove effect.id) ] [ text "Usuń" ]
                            ]
                 in
                 if List.isEmpty effects then
                    [ text "Brak" ]

                 else
                    List.map effectToDivWithDeletion effects
                )

        courseEffectAddButton : Html Message
        courseEffectAddButton =
            button [ onClick AddEffect ] [ text "Dodaj efekt" ]

        courseAddButton : Html Message
        courseAddButton =
            button [ onClick AddCourse ] [ text "Dodaj przedmiot" ]
    in
    div []
        [ div []
            [ div [] [ input [ placeholder "ID", value model.courseId, onInput CourseIdInput ] [] ]
            , div [] [ input [ placeholder "Nazwa", value model.courseName, onInput CourseNameInput ] [] ]
            , div [] [ input [ placeholder "ECTS", value (String.fromInt model.courseEcts), onInput CourseEctsInput ] [] ]
            , div [] [ courseTypeSelection ]
            , div [] [ courseEffectsList ]
            , div [] [ courseEffectSelection, courseEffectAddButton ]
            , div [] [ courseAddButton ]
            ]
        , courseTable
        ]
