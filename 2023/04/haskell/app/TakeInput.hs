module TakeInput where

import System.IO (isEOF)

takeInput :: String -> IO String
takeInput x = do
  done <- isEOF
  if done
    then return x
    else do
      inp <- getLine
      takeInput (x ++ "\n" ++ inp)
