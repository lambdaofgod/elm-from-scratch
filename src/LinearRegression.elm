module UserInput exposing (..)

import Chart exposing (Scale, Datum)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Svg exposing (svg)
import Svg.Attributes exposing (width, height)
import ScatterPlot exposing (scatterPlot, color, size)


main =
    Html.beginnerProgram {model = model, view = view, update = update}

type Point2D = MakePoint2D Float Float

type alias Model =
    {x : Float, y : Float, points : List Point2D}


model : Model
model =
    {x = 0, y = 0, points = []}


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateX new_x -> {model | x = new_x}
        UpdateY new_y -> {model | y = new_y}
        AddPoint -> {model | points = model.points ++ [MakePoint2D model.x model.y]}


type Msg
    = UpdateX Float |
      UpdateY Float |
      AddPoint


parse_float_with_default : Float -> String -> Float
parse_float_with_default default string = string |> String.toFloat |> Result.withDefault default

point_to_datum : Point2D -> Datum msg
point_to_datum point =
  case point of
    MakePoint2D x y -> (x, y, [])

view : Model -> Html Msg
view model =
    div [] [
          input [ placeholder "x", onInput (\x -> x |> parse_float_with_default 0.0 |> UpdateX)] [],
          input [ placeholder "y", onInput (\y -> y |> parse_float_with_default 0.0 |> UpdateY)] [],
          button [ onClick AddPoint] [ text "Add point"],
          svg
            [
              Svg.Attributes.width "800",
              Svg.Attributes.height "600"
            ]
            [
              scatterPlot
                [
                  ScatterPlot.size "6",
                  ScatterPlot.color "#D5B545"
                ]
                { data = List.map point_to_datum model.points,
                  xScale = (\x -> 400 + 100 * x),
                  yScale = (\y -> 400 - 100 * y)
                }

            ]
          ]
