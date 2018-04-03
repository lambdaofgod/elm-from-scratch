module View exposing (view)

import Chart exposing (Scale, Datum)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Svg exposing (svg, Svg)
import Svg.Attributes exposing (width, height)
import Chart exposing (ChartProps)
import ScatterPlot exposing (scatterPlot, color, size)
import LineChart exposing (lineChart, color)
import LinearRegression exposing (..)
import Model exposing (Model, model)
import Math.Vector2 exposing (..)
import Msg exposing (..)


point_to_datum : Point2D -> Datum msg
point_to_datum point = (getX point, getY point, [])

parse_float_with_default : Float -> String -> Float
parse_float_with_default default string = string |> String.toFloat |> Result.withDefault default

regression_line_points : RegressionCoeffs -> List Point2D
regression_line_points regression_coeffs =
  let
    linear_function x = regression_coeffs.slope * x + regression_coeffs.intercept
    (start_x, end_x) = (-4, 4)
  in
    [
      make_point_2d start_x (linear_function start_x),
      make_point_2d  end_x (linear_function end_x)
    ]

plot_data : List Point2D -> (ChartProps msg)
plot_data points =
  {
    data = List.map point_to_datum points,
    xScale = (\x -> 400 + 100 * x),
    yScale = (\y -> 400 - 100 * y)
  }

draw_scatterplot scatterplot_data =
  scatterPlot
    [
      ScatterPlot.size "10",
      ScatterPlot.color "#D5B545"
    ]
    scatterplot_data

draw_line_chart regression_data =
    lineChart
    [
      LineChart.color "#7E94C7",
      LineChart.width "4"
    ]
    regression_data

view : Model -> Html Msg
view model =
    let
      regression_data = plot_data (regression_line_points model.regression_coeffs)
      scatterplot_data = plot_data model.points
    in
      div [] [
            input [ placeholder "x", onInput (\x -> x |> parse_float_with_default 0.0 |> UpdateX)] [],
            input [ placeholder "y", onInput (\y -> y |> parse_float_with_default 0.0 |> UpdateY)] [],
            button [ onClick AddPoint] [ text "Add point"],
            button [ onClick RenderLine] [ text "Calculate linear regression coefficients"],
            svg
              [
                Svg.Attributes.width "1200",
                Svg.Attributes.height "800"
              ]
              [
                draw_scatterplot scatterplot_data,
                draw_line_chart regression_data
              ]
            ]

