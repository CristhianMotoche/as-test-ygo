{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Main where

import qualified Data.Aeson           as A
import           Data.Aeson.Schema    (Object, schema)
import qualified Data.ByteString.Lazy as BS

type Data = [schema|
  {
    data: List #Card
  }
|]

type Card = [schema|
  {
    id: Int,
    name: Text,
    type: Text,
    desc: Text,
    atk: Int,
    def: Int,
    level: Int,
    race: Text,
    attribute: Text,
    archetype: Text,
    card_sets: List #CardSet,
    card_images: List #CardImage,
    card_prices: List #CardPrices,
  }
|]

type CardSet = [schema|
  {
    set_name: Text,
    set_code: Text,
    set_rarity: Text,
    set_rarity_code: Text,
    set_price: Text,
  }
|]

type CardImage = [schema|
  {
    id: Int,
    image_url: Text,
    image_url_small: Text,
  }
|]

type CardPrices = [schema|
  {
    cardmarket_price: Text,
    tcgplayer_price: Text,
    ebay_price: Text,
    amazon_price: Text,
    coolstuffinc_price: Maybe Text,
  }
|]


main :: IO ()
main =
  let decodeStr :: BS.ByteString -> Either String (Object Data)
      decodeStr = A.eitherDecode
   in BS.readFile "time-wizard.json" >>= print . decodeStr
