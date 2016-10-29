module Funnel.View exposing (rootView)

import Html exposing (Html, text, div, table, thead, tbody, tr, th, td, select, option)
import Html.Attributes exposing (style, class, value)
import List exposing (map, head)
import String exposing (append)
import Utils exposing (pct, maxValue)
import Funnel.Types exposing (Model, Msg, Step, Item)

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
    steps =
      case (head model.data) of
        Nothing -> []
        Just value -> value.steps
    maxCount = maxValue (map (\n -> n.count) steps)
  in
    case maxCount of
      0 ->
        div [] []
      value ->
        div [class "chart"] (map (chartBarView maxCount) steps)

tableCell : String -> Html Msg
tableCell value =
  td [class "table__cell"] [text value]

tableCellView : Step -> Html Msg
tableCellView step =
  tableCell(toString step.count)

tableRowView : Item -> Html Msg
tableRowView item =
  tr [] ((tableCell item.property.value) :: (map tableCellView item.steps))
  -- [ td [class "table__cell"] [text item.property.value]
  -- , td [class "table__cell"] [text step.name]
  -- , td [class "table__cell"] [text (toString step.count)]
  -- ]

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
