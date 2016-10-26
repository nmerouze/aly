module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import Utils

all : Test
all =
  describe "Utils"
    [ describe "pct"
      [ test "calculates percentage" <|
        \() ->
          Expect.equal (Utils.pct 10 1) "10"
      ]
    , describe "maxValue"
      [ test "finds max value in list" <|
        \() ->
          Expect.equal (Utils.maxValue [3, 2, 5]) 5
      , test "returns 0 when list is empty" <|
        \() ->
          Expect.equal (Utils.maxValue []) 0
      ]
    ]
