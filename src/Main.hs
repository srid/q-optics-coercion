{-# LANGUAGE UndecidableInstances #-}

module Main where

import Main.Utf8 (withUtf8)
import Optics.Core

newtype Stringable a = Stringable a
  deriving newtype (ToString, IsString)

newtype MyPrism a
  = MyPrism (Prism' FilePath a)

-- MyPrism (a -> String, String -> Maybe a)

class MkPrism a where
  mkPrism :: MyPrism a

instance (IsString a, ToString a) => MkPrism (Stringable a) where
  mkPrism = error "not implemented"

newtype Foo = Foo Text
  deriving newtype (IsString, ToString)
  deriving (MkPrism) via (Stringable Foo)

main :: IO ()
main = do
  -- For withUtf8, see https://serokell.io/blog/haskell-with-utf8
  withUtf8 $ do
    putStrLn "Hello 🌎"
