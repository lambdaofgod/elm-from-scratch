import Html exposing (Html, div, text, program)
import Mouse


-- MODEL
type alias Model =
    Mouse.Position


init : ( Model, Cmd Msg )
init =
    ({x = 0, y = 0}, Cmd.none )


-- MESSAGES
type Msg
    = MouseMsg Mouse.Position


-- VIEW
view : Model -> Html Msg
view model =
    div []
        [(.x model, .y model) |> toString |> text]


-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg position ->
            ( position, Cmd.none )


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseMsg]



-- MAIN
main : Program Never Model Msg
main =
    program
        {
          init = init,
          view = view,
          update = update,
          subscriptions = subscriptions
        }

