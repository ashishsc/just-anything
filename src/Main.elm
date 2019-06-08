module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, text)
import Html.Attributes as Atrs
import Html.Events exposing (onClick, onInput)


type alias Model =
    { questions : List FormElement }


init : ( Model, Cmd Msg )
init =
    ( { questions = [] }, Cmd.none )


type Msg
    = CreateNode


type FormElement
    = Markdown String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CreateNode ->
            ( { model | questions = Markdown "<new>" :: model.questions }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    let
        modelDebug =
            div [] [ text (Debug.toString model) ]
    in
    div [] <|
        [ modelDebug
        , Html.button
            [ onClick <| CreateNode ]
            [ text "click me you fuck" ]
        ]
            ++ List.indexedMap
                viewFormElement
                model.questions


viewFormElement : Int -> FormElement -> Html Msg
viewFormElement i e =
    case e of
        Markdown s ->
            Html.text s


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
