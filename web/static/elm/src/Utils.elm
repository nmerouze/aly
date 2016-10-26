module Utils exposing (pct, maxValue)

import List exposing (map, maximum)

pct : Int -> Int -> String
pct maxValue value =
  toString (ceiling ((toFloat value) * 100 / (toFloat maxValue)))

maxValue : List Int -> Int
maxValue list =
  case maximum (map (\n -> n) list) of
    Nothing -> 0
    Just value -> value
