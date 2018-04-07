module LinearRegressionTests exposing (..)

import Test exposing (..)
import Expect
import LinearRegression exposing (..)


linear_regression_test : Test
linear_regression_test =
  describe "Linear Regression Test"
    [
      test "Getting coefficients for y=x" (
        \() ->
          let
           points = [make_point_2d 1 1, make_point_2d 0 0]
           coefficients = get_linear_regression_coeffs points
           correct_coefficients = {slope = 1, intercept = 0}
          in
            Expect.equal coefficients correct_coefficients
      ),
      test "Getting coefficients for y=x+1" (
        \() ->
          let
           points = [make_point_2d 1 2, make_point_2d 0 1]
           coefficients = get_linear_regression_coeffs points
           correct_coefficients = {slope = 1, intercept = 1}
          in
            Expect.equal coefficients correct_coefficients
      )
    ]