module App exposing (..)

import Html exposing (Html, text, div)
import Html.Attributes exposing (style, class)
import Html.App exposing (programWithFlags)
import List exposing (length, map, maximum, repeat)
import String exposing (append)

-- Types

type alias Step = { name: String, count: Int }
type alias Flags = { steps: List Step }
type alias Model = List Step

-- Functions

pct : Int -> Int -> String
pct max value = (toString (ceiling ((toFloat value) * 100 / (toFloat max))))

barView label value =
  div [style [("height", value)], class "chart__step"]
  [ div [class "chart__stepBar"] []
  , div [class "chart__stepLabel"] [text label]
  , div [class "chart__stepValue"] [text value]
  ]

bar model =
  let
    max = case maximum (map (\n -> n.count) model) of
      Nothing -> 0
      Just value -> value
  in
    \step -> barView step.name (append (pct max step.count) "%")

-- Rendering

init : Flags -> (Model, Cmd String)
init flags =
  (flags.steps, Cmd.none)

view : Model -> Html String
view model =
  div [class "chart"] (map (bar model) model)

update : String -> Model -> (Model, Cmd String)
update msg model = (model, Cmd.none)

main =
  programWithFlags
    { init = init
    , update = update
    , subscriptions = \_ -> Sub.none
    , view = view
    }
