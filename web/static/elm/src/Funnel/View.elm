module Funnel.View exposing (rootView)

import Html exposing (Html, text, div, table, thead, tbody, tr, th, td, select, option)
import Html.Attributes exposing (style, class, value)
import List exposing (map)
import String exposing (append)
import Utils exposing (pct, maxValue)
import Funnel.Types exposing (Model, Msg, Step)

chartBarView : Int -> Step -> Html Msg
chartBarView maxCount =
  \step ->
    let
      value = (append (pct maxCount step.count) "%")
    in
      div [style [("height", value)], class "chart__step"]
      [ div [class "chart__stepBar"] []
      , div [class "chart__stepLabel"] [text step.name]
      , div [class "chart__stepValue"] [text value]
      ]

chartView : Model -> Html Msg
chartView model =
  let
    maxCount = maxValue (map (\n -> n.count) model.steps)
  in
    case maxCount of
      0 ->
        div [] []
      value ->
        div [class "chart"] (map (chartBarView maxCount) model.steps)

tableRowView : Step -> Html Msg
tableRowView step =
  tr []
  [ td [class "table__cell"] [text (toString step.number)]
  , td [class "table__cell"] [text step.name]
  , td [class "table__cell"] [text (toString step.count)]
  ]

tableView : Model -> Html Msg
tableView model =
  table [class "table"]
  [ thead []
    [ tr []
      [ th [class "table__header"] [text "Step"]
      , th [class "table__header"] [text "Event"]
      , th [class "table__header"] [text "Count"]
      ]
    ]
  , tbody [] (map tableRowView model.steps)
  ]

optionView : String -> Html Msg
optionView property =
  option [value property] [text property]

selectListView : Model -> Html Msg
selectListView model =
  select [] (map optionView ("" :: model.properties))

rootView : Model -> Html Msg
rootView model =
  div []
  [ chartView(model)
  , selectListView(model)
  , tableView(model)
  ]
