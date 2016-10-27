module Funnel.State exposing (..)

import Funnel.Types exposing(Model, Msg)

initialState : Model -> (Model, Cmd Msg)
initialState model =
  (model, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
