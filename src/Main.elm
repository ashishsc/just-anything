module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Element exposing (Element, column, el, row, text)
import Element.Input as Input
import Html exposing (Html)
import Markdown as MarkdownParser


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
            ( { model | questions = Markdown "# new" :: model.questions }
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    let
        modelDebug =
            el [] <| text (Debug.toString model)

        questions =
            List.indexedMap viewFormElement model.questions

        createNodeButton =
            Input.button []
                { onPress = Just CreateNode
                , label = text "Click me you fuck"
                }
    in
    Element.layout [] <| column [] ([ modelDebug, createNodeButton ] ++ questions)


viewFormElement : Int -> FormElement -> Element Msg
viewFormElement i e =
    case e of
        Markdown markdownStr ->
            Element.html <| MarkdownParser.toHtml [] markdownStr


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
