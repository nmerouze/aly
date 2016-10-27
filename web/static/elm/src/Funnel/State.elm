module Funnel.State exposing (..)

import Funnel.Types exposing(Flags, Model, Msg)

initialState : Flags -> (Model, Cmd Msg)
initialState flags =
  (flags.steps, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
