module Funnel exposing(main)

import Html.App exposing (programWithFlags)
import Funnel.State exposing (initialState, update, subscriptions)
import Funnel.View exposing (rootView)

main =
  programWithFlags
    { init = initialState
    , update = update
    , subscriptions = subscriptions
    , view = rootView
    }
