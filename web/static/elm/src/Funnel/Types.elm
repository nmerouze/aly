module Funnel.Types exposing (..)

import Http

type alias Property =
  { name: String
  , value: String
  }

type alias Item =
  { property: Property
  , steps: List Step
  }

type alias ItemList = List Item

type alias Step =
  { name: String
  , count: Int
  }

type alias Model =
  { id: String
  , steps: List String
  , data: ItemList
  , properties: List String
  }

type Msg
  = LoadData String
  | LoadSucceed ItemList
  | LoadFail Http.Error
