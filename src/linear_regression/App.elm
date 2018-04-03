module App exposing (..)

import Html exposing (..)
import Html.Events exposing (onInput, onClick)
import Update exposing (update)
import Model exposing (Model, model)
import View exposing (view)


main =
    Html.beginnerProgram {model = model, view = view, update = update}

