module Main exposing (main)

import Browser
import Html exposing (Html, div, text)
import Html.Attributes as Attrs
import Html.Events as Events


type Suit
    = Green
    | Yellow
    | Red
    | Blue
    | Pink


toString : Suit -> String
toString suit =
    case suit of
        Green ->
            "Green"

        Yellow ->
            "Yellow"

        Red ->
            "Red"

        Blue ->
            "Blue"

        Pink ->
            "Pink"


type alias Model =
    { chosenSuit : Maybe Suit }


initialModel : Model
initialModel =
    { chosenSuit = Nothing }


allSuits : List Suit
allSuits =
    [ Green, Yellow, Red, Blue ]


selectOptions : List (Html Msg)
selectOptions =
    List.map
        (\color ->
            Html.option
                [ Attrs.value (toString color) ]
                [ text (toString color) ]
        )
        allSuits


view : Model -> Html Msg
view model =
    div []
        [ Html.h2 [] [ text "Choose your Power Ranger Suit" ]
        , Html.select [ Events.onInput ChooseSuit ]
            (Html.option [ Attrs.value "" ] [ text "Choose" ]
                :: selectOptions
            )
        , Html.p []
            [ case model.chosenSuit of
                Nothing ->
                    text "No suit was chosen."

                Just suit ->
                    text ("Your choice: " ++ toString suit)
            ]
        ]


type Msg
    = ChooseSuit String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChooseSuit value ->
            { model | chosenSuit = fromString value }


fromString : String -> Maybe Suit
fromString str =
    case str of
        "Green" ->
            Just Green

        "Yellow" ->
            Just Yellow

        "Red" ->
            Just Red

        "Blue" ->
            Just Blue

        "Pink" ->
            Just Pink

        _ ->
            Nothing


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
