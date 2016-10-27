module Funnel.View exposing (rootView)

import Html exposing (Html, text, div)
import Html.Attributes exposing (style, class)
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
    maxCount = maxValue (map (\n -> n.count) model)
  in
    case maxCount of
      0 ->
        div [] []
      value ->
        div [class "chart"] (map (chartBarView maxCount) model)

rootView : Model -> Html Msg
rootView model =
  chartView(model)
