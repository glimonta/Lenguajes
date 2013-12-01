{-# LANGUAGE TupleSections #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE UnicodeSyntax #-}

import Control.Monad      ((=<<))
import Data.Bool          (otherwise)
import Data.Eq            ((==))
import Data.Function      (($), (.), id)
import Data.Functor       ((<$>), fmap)
import Data.Int           (Int)
import Data.List          ((++), dropWhileEnd, length, null, tails, take, zipWith)
import Data.Map           (Map, fromList, fromListWith, mapWithKey, lookup, intersectionWith)
import Data.Maybe         (maybe)
import Data.Monoid        ((<>))
import Data.Ord           ((<), Ord)
import Data.String        (String)
import Prelude            ((+), (*), (/), fromIntegral)
import System.Environment (getArgs)
import System.IO          (IO, getLine, print)
import Text.Read          (read)



--tabular ∷ ∀ a. Ord a ⇒ Int → [a] → Map [a] Int
tabular n secuencia
  | n == 0    = fromList [([], fromIntegral $ length secuencia)]
  | otherwise = fromListWith (+) $ (, 1) <$> contextos
  where
--    contextos ∷ [[a]]
    contextos
      = dropWhileEnd (\ l → length l < n)
      . fmap (take n)
      . tails
      $ secuencia



--probabilidades ∷ [a] → [a] → [(Double, a)]
probabilidades secuencia contexto
  = if null contexto
    then simples
    else simples .+ condicionales

  where
    tabla1 = tabular 1 secuencia
    tabla2 = tabular 2 secuencia
    n      = length secuencia

    (.+) = intersectionWith (+)

    simples = (* ((3/10)/n)) <$> tabla1

    condicionales
      = mapWithKey f tabla1
      where
        frecuenciaContexto = lookup contexto tabla1
        f evento _
          = (* ((7/10)/frecuenciaContexto))
          . maybe 0 id
          $ lookup (contexto <> evento) tabla2


main ∷ IO ()
main
  = do
    [n] ← getArgs
    print . tabular (read n) =<< getLine
