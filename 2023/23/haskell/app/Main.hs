module Main where

import TakeInput (takeInput)

main :: IO ()
main = do
  input <- takeInput ""
  putStr input
