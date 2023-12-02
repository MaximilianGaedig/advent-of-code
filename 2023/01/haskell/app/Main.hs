module Main where

import Data.Char (digitToInt, isDigit, intToDigit)
import Data.List (intercalate)
import GHC.Real (reduce)
import TakeInput (takeInput)
import Text.Printf (IsChar (toChar))

getDigits :: String -> String
getDigits = filter isDigit

filterIndexed :: (a -> Int -> Bool) -> [a] -> [a]
filterIndexed p xs = [x|(x,i) <- zip xs [0..], p x i]

literals = ["one","two","three","four","five","six","seven","eight","nine"]

enumerate::[a]->[(Int,a)]
enumerate = zip [0..]

windows :: Int -> [a] -> [[a]]
windows n xs
    | length xs < n = []
    | otherwise     = take n xs : windows n (tail xs)

eqIndexed :: String->(Int,String) ->Bool
eqIndexed  x y = x == snd y

indexesOfLiteral literal x = map fst (filter (eqIndexed literal) (enumerate (windows (length literal) x)))

convertToReplacementListIndex :: Int -> (Int,Int) -> Int
convertToReplacementListIndex len i = snd i - (fst i * (len - 2))

tupleReplaceAll :: String-> [(String,String)] -> String
tupleReplaceAll x replaces
 | null replaces = x
 | otherwise = tupleReplaceAll (uncurry replaceAll (head replaces) x) (tail replaces)

removeFromStart :: String -> Int -> String
removeFromStart x i
  | i < 1 = x
  | null x = []
  | otherwise = removeFromStart (tail x) (i-1)

beginsWith x with = with == take (length with) x


getIndexesToReplace :: String -> String -> [Int]
getIndexesToReplace from x = map (convertToReplacementListIndex (length from)) (enumerate (indexesOfLiteral from x))

isIndexWithLen :: Int -> Int -> (Int,a) -> Bool
isIndexWithLen len i x = i <= fst x && fst x < i + len

notIndexWithLen len i x = not (isIndexWithLen len i x)

removeAtIndex :: Int -> Int -> [a] -> [a]
removeAtIndex len i x = map snd (filter (notIndexWithLen len i) (enumerate x))

insertAt :: String -> Int -> String -> String
insertAt el _ [] = el
insertAt el 0 as = el ++ as
insertAt el i (x:xs) = x : insertAt el (i - 1) xs

replaceAtIndex fromLen to x i  = insertAt to i (removeAtIndex fromLen i x)

replaceAtIndexWithTuple :: String -> Int -> [(String,String)] -> (String,Bool)
replaceAtIndexWithTuple x i literals
  | null literals = (x, False)
  | beginsWith (removeFromStart x i) (fst (head literals)) = (replaceAtIndex (length (fst (head literals))) (snd (head literals)) x i, True)
  | otherwise = replaceAtIndexWithTuple x i (tail literals)

enumeratedLiterals = zip literals (map intToDigitString [1..])

replaceFirst :: (String,Bool) -> [(String,String)] -> Int -> (String,Bool)
replaceFirst (x, hasReplaced) literals i
  | hasReplaced = (x, True)
  | i > length x = (x, False)
  | not hasReplaced = replaceFirst (replaceAtIndexWithTuple x i enumeratedLiterals) literals (i+1)

replaceLast :: (String,Bool) -> [(String,String)] -> Int -> (String,Bool)
replaceLast (x, hasReplaced) literals i
  | hasReplaced = (x, True)
  | i < 1 = (x, False)
  | not hasReplaced = replaceLast (replaceAtIndexWithTuple x i enumeratedLiterals) literals (i-1)

replaceFromEnds x = fst (replaceLast (fst (replaceFirst (x,False) enumeratedLiterals 0),False) enumeratedLiterals (length x-1))

replaceAllIdxs fromLen to x idxs
  | null idxs = x
  | otherwise = replaceAllIdxs fromLen to (replaceAtIndex fromLen to x (head idxs)) (tail idxs)

replaceAll :: String -> String -> String -> String
replaceAll from to x = replaceAllIdxs (length from) to x (getIndexesToReplace from x)

intToDigitString x= [intToDigit x]
replaceAllLiteralNums x = tupleReplaceAll x (zip literals (map intToDigitString [1..]) )

getFirstAndLastNum :: String -> String
getFirstAndLastNum input =
  let nums = getDigits (replaceFromEnds input)
   in case nums of
        [] -> ""
        xs -> [head xs, last xs]

getCalibrationValues :: String -> [String]
getCalibrationValues input = filter (not . null) (map getFirstAndLastNum (lines input))

toInt x = read x :: Int

sumCalibrationNumbers x = sum (map toInt (getCalibrationValues x))

-- filter isNumber
main :: IO ()
main = do
  input <- takeInput ""
  --putStr (show (replaceLast ("ieightwothree",False) enumeratedLiterals 9))
  -- putStr (show (map replaceFromEnds (lines input)))
  -- putStr (show (sumCalibrationNumbers input))
  putStr (show (map toInt (getCalibrationValues input)))
