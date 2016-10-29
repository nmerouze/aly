module Funnel.State exposing (..)

import Funnel.Types exposing (..)
import Http
import Json.Decode exposing (..)
import Task

initialState : Model -> (Model, Cmd Msg)
initialState model =
  (model, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    LoadData property ->
      (model, loadFunnel model.id property)
    LoadSucceed data ->
      ({ model | data = data }, Cmd.none)
    LoadFail _ ->
      (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

loadFunnel : String -> String -> Cmd Msg
loadFunnel id property =
  let
    url =
      "/private/funnels/" ++ id ++ "?property=" ++ property
  in
    Task.perform LoadFail LoadSucceed (Http.get decodeData url)

decodeData : Decoder ItemList
decodeData =
  at ["data"] (list decodeItem)

decodeItem : Decoder Item
decodeItem =
  object2
    Item
    ("property" := decodeProperty)
    ("steps" := list decodeStep)

decodeProperty : Decoder Property
decodeProperty =
  object2
    Property
    ("name" := string)
    ("value" := string)

decodeStep : Decoder Step
decodeStep =
  object2
    Step
    ("name" := string)
    ("count" := int)
