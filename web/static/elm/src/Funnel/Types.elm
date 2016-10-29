module Funnel.Types exposing (..)

type alias Property =
  { name: String
  , value: String
  }

type alias Item =
  { property: Property
  , steps: List Step
  }

type alias Step =
  { name: String
  , count: Int
  }

type alias Model =
  { steps: List String
  , data: List Item
  , properties: List String
  }

type Msg = String
