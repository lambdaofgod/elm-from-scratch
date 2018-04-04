module Update exposing (update)

import Model exposing (Model, model)
import LinearRegression exposing (make_point_2d, get_linear_regression_coeffs)
import Msg exposing (..)


update : Msg -> Model -> Model
update msg model =
  case msg of
    UpdateX new_x -> {model | x = new_x}
    UpdateY new_y -> {model | y = new_y}
    AddPoint -> {model | points = (make_point_2d model.x model.y) :: model.points}
    RenderLine -> {model | regression_coeffs = get_linear_regression_coeffs model.points}
