module Chart exposing (main)

import Html exposing (Html, text, div)
import Html.Attributes exposing (style, class)
import Html.App exposing (programWithFlags)
import List exposing (length, map, repeat)
import String exposing (append)
import Utils exposing (pct, maxValue)

type alias Step = { name: String, count: Int }
type alias Flags = { steps: List Step }
type alias Model = List Step

bar : Int -> Step -> Html String
bar maxCount =
  \step ->
    let
      value = (append (pct maxCount step.count) "%")
    in
      div [style [("height", value)], class "chart__step"]
      [ div [class "chart__stepBar"] []
      , div [class "chart__stepLabel"] [text step.name]
      , div [class "chart__stepValue"] [text value]
      ]

init : Flags -> (Model, Cmd String)
init flags =
  (flags.steps, Cmd.none)

view : Model -> Html String
view model =
  let
    maxCount = maxValue (map (\n -> n.count) model)
  in
    case maxCount of
      0 ->
        div [] []
      value ->
        div [class "chart"] (map (bar maxCount) model)

update : String -> Model -> (Model, Cmd String)
update msg model = (model, Cmd.none)

main =
  programWithFlags
    { init = init
    , update = update
    , subscriptions = \_ -> Sub.none
    , view = view
    }
