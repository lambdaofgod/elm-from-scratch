module App exposing (..)

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


main =
    Html.beginnerProgram {model = model, view = view, update = update}


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


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateX new_x -> {model | x = new_x}
        UpdateY new_y -> {model | y = new_y}
        AddPoint -> {model | points = (make_point_2d model.x model.y) :: model.points}
        RenderLine -> {model | regression_coeffs = get_linear_regression_coeffs model.points}

type Msg
    = UpdateX Float |
      UpdateY Float |
      AddPoint |
      RenderLine


parse_float_with_default : Float -> String -> Float
parse_float_with_default default string = string |> String.toFloat |> Result.withDefault default

regression_line_points : RegressionCoeffs -> List Point2D
regression_line_points regression_coeffs =
  [
    make_point_2d -400 (regression_coeffs.intercept - 400),
    make_point_2d 400 (400 * regression_coeffs.slope + regression_coeffs.intercept)
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
