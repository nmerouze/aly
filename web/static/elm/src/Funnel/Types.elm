module Funnel.Types exposing (..)

type alias Step = { number: Int, name: String, count: Int }
type alias Model = { steps: List Step, properties: List String }
type Msg = String
