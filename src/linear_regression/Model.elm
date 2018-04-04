module Model exposing (Model, model)

import LinearRegression exposing (RegressionCoeffs, Point2D)


type alias Model =
  {
    x : Float,
    y : Float,
    points : List Point2D,
    regression_coeffs: RegressionCoeffs
  }


model : Model
model =
  {x = 0, y = 0, points = [], regression_coeffs = {slope = 0, intercept = 0}}
