{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE UnicodeSyntax #-}

import Control.Applicative (pure)
import Control.Monad       ((=<<))
import Data.Bool           (otherwise)
import Data.Eq             ((==))
import Data.Function       (($), (.), id)
import Data.Functor        ((<$>), fmap)
import Data.List           (dropWhileEnd, null, tails)
import Data.Map            (Map, fromList, fromListWith, mapWithKey, lookup, intersectionWith)
import Data.Maybe          (Maybe, maybe)
import Data.Monoid         ((<>))
import Data.Ord            ((<), Ord)
import Prelude             ((+), (*), (/), Fractional, Integer, Integral, Num, fromIntegral)
import System.Environment  (getArgs)
import System.IO           (IO, getLine, print)
import Text.Read           (read)

import qualified Data.List as L (length, take)

length ∷ Num c ⇒ [a] →  c
length = fromIntegral . L.length

take ∷ Integral a ⇒ a → [a1] → [a1]
take = L.take . fromIntegral



tabular
  ∷ ∀ evento frecuencia. (Num frecuencia, Ord evento)
  ⇒ Integer → [evento] → Map [evento] frecuencia

tabular orden secuencia
  | orden == 0    = fromList [([], length secuencia)]
  | otherwise = fromListWith (+) $ (, 1) <$> contextos
  where
    contextos ∷ [[evento]]
    contextos
      = dropWhileEnd (\ l → length l < orden)
      . fmap (take orden)
      . tails
      $ secuencia


probabilidades
  ∷ ∀ evento probabilidad. (Fractional probabilidad, Ord evento)
  ⇒ [evento] → [evento] → Maybe (Map [evento] probabilidad)

probabilidades secuencia contexto
  = if null contexto
    then pure simples
    else do
      frecuenciaContexto ← lookup contexto tabla1
      pure $ simples .+ condicionales frecuenciaContexto

  where
    tabla1 = tabular 1 secuencia
    tabla2 = tabular 2 secuencia
    n      = length secuencia

    (.+) = intersectionWith (+)

    simples = (* ((3/10)/n)) <$> tabla1

    condicionales ∷ probabilidad → Map [evento] probabilidad
    condicionales frecuenciaContexto
      = mapWithKey f tabla1

      where
        f ∷ [evento] → Integer → probabilidad
        f evento _
          = (* ((7/10)/frecuenciaContexto))
          . maybe 0 id
          $ lookup (contexto <> evento) tabla2



main ∷ IO ()
main
  = do
    [n] ← getArgs
    print . tabular (read n) =<< getLine
