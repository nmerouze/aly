module Funnel.Types exposing (..)

type alias Step = { number: Int, name: String, count: Int }
type alias Flags = { steps: List Step }
type alias Model = List Step
type Msg = String
