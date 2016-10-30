module Funnel.View exposing (rootView)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List exposing (map, head)
import String exposing (append)
import Utils exposing (pct, maxValue)
import Funnel.Types exposing (..)

-- CHART

chartBarView : Int -> Step -> Html Msg
chartBarView maxCount =
  \step ->
    let
      value = (append (pct maxCount step.value) "%")
    in
      div [style [("height", value)], class "chart__step"]
      [ div [class "chart__stepBar"] []
      , div [class "chart__stepLabel"] [text step.name]
      , div [class "chart__stepValue"] [text value]
      ]

chartView : Model -> Html Msg
chartView model =
  let
    steps =
      case (head model.data) of
        Nothing -> []
        Just value -> value.steps
    maxCount = maxValue (map (\n -> n.value) steps)
  in
    case maxCount of
      0 ->
        div [] []
      value ->
        div [class "chart"] (map (chartBarView maxCount) steps)

-- TABLE

tableCell : String -> Html Msg
tableCell value =
  td [class "table__cell"] [text value]

tableCellView : Step -> Html Msg
tableCellView step =
  tableCell(toString step.value)

tableRowView : Item -> Html Msg
tableRowView item =
  tr [] ((tableCell item.property.value) :: (map tableCellView item.steps))

tableHeaderView : String -> Html Msg
tableHeaderView step =
  th [class "table__header"] [text step]

tableView : Model -> Html Msg
tableView model =
  table [class "table"]
  [ thead []
    [ tr [] (map tableHeaderView ("" :: model.steps))
    ]
  , tbody [] (map tableRowView model.data)
  ]

-- SELECT LIST

optionView : String -> Html Msg
optionView property =
  option [value property] [text property]

selectListView : Model -> Html Msg
selectListView model =
  select [onInput LoadData] (map optionView ("" :: model.properties))

-- CONTAINER

rootView : Model -> Html Msg
rootView model =
  div []
  [ chartView(model)
  , selectListView(model)
  , tableView(model)
  ]
