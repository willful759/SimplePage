module Main exposing ( .. )
import Browser
import Html exposing (Html, button, div, text, h1, a, iframe)
import Html.Events exposing (onClick)
import Html.Attributes exposing (href, attribute, src)

import Bootstrap.Accordion as Accordion
import Bootstrap.Card.Block as Block

main =
  Browser.sandbox { init = init, update = update, view = view }

type Msg = AccordionMsg Accordion.State

type alias Model = 
  { accordionState: Accordion.State }

init: Model
init = { accordionState = Accordion.initialState }

update (AccordionMsg state) model = 
  { model | accordionState = state }

hyperlink attr link inner = a ([ href link ] ++ attr) inner 

simpleCard id txt inner = 
  Accordion.card
  { id = id
  , options = []
  , header = 
    Accordion.header [] <| Accordion.toggle [] [ text txt ]
  , blocks = 
    [ Accordion.block []
      [ Block.text [] inner ]
    ]
  }

cards: Model -> Html Msg
cards model = Accordion.config AccordionMsg 
  |> Accordion.withAnimation
  |> Accordion.cards
      [ simpleCard "card1" "Oshi" 
        [ hyperlink [] "https://www.youtube.com/watch?v=jK5BcSYh70s" 
          [ text "Takanashi Kiwawa" ] 
        ]
      , simpleCard "card2" "Favorite video"
        [ hyperlink [] "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
          [ text"https://www.youtube.com/watch?v=dQw4w9WgXcQ" ]
        ]
      , simpleCard "card3" "Favorite band"
        [ hyperlink [] "https://www.youtube.com/watch?v=0Gm2TudHe0s"
          [ text "King Gizzard and the Lizard Wizzard" ]
        ]
      ]
  |> Accordion.view model.accordionState

view model = div [] 
  [ h1 [] [ text "About me" ]
  , text "I'm Ivan Pineda lmao"
  , cards model
  ]


subscriptions model =
    Accordion.subscriptions model.accordionState AccordionMsg
