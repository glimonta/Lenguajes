{-# LANGUAGE TupleSections #-}

import Control.Monad      ((=<<))
import Data.Bool          (otherwise)
import Data.Eq            ((==))
import Data.Function      (($), (.))
import Data.Functor       ((<$>), fmap)
import Data.Int           (Int)
import Data.List          ((++), dropWhileEnd, length, tails, take, zipWith)
import Data.Map           (Map, fromList, fromListWith)
import Data.Ord           ((<))
import Data.String        (String)
import Prelude            ((+))
import System.Environment (getArgs)
import System.IO          (IO, getLine, print)
import Text.Read          (read)


tabular :: Int -> String -> Map String Int
tabular n secuencia
  | n == 0    = fromList [("", length secuencia)]
  | otherwise = fromListWith (+) $ (, 1) <$> contextos
  where
    contextos :: [String]
    contextos
      = dropWhileEnd (\ l -> length l < n)
      . fmap (take n)
      . tails
      $ secuencia

main :: IO ()
main
  = do
    [n] <- getArgs
    print . tabular (read n) =<< getLine
