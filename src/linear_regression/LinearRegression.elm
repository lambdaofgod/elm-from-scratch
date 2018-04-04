module LinearRegression exposing (..)
import Math.Vector2 exposing (..)


type alias Point2D = Vec2
type alias RegressionCoeffs = {slope: Float, intercept: Float}

make_point_2d : Float -> Float -> Vec2
make_point_2d = vec2

zero : Point2D
zero = vec2 0 0

minus : Point2D -> Point2D
minus point = sub zero point

mean : List Point2D -> Point2D
mean points =
  let
    len = List.length points
    sum = List.foldr add (vec2 0 0) points
  in
    scale (1 / (toFloat len)) sum


--linear regression helpers
get_linear_regression_coeffs: List Point2D -> RegressionCoeffs
get_linear_regression_coeffs points =
  let
    mean_point = mean points
    centered_points = List.map (add (minus mean_point)) points
    norm = List.foldr (\point acc -> getX point ^ 2 + acc) 0 centered_points
    corr = List.foldr (\point acc -> (getX point) * (getY point) + acc) 0 centered_points
    slope = corr / norm
    intercept = (getY mean_point) - (slope * getX mean_point)
  in
    {slope = slope, intercept = intercept}