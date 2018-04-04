module App exposing (..)

import Html exposing (..)
import Update exposing (update)
import Model exposing (Model, model)
import Msg exposing (Msg)
import View exposing (view)


main : Program Never Model Msg
main =
  Html.beginnerProgram {model = model, view = view, update = update}
