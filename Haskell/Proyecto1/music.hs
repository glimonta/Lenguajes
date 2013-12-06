{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE UnicodeSyntax #-}

module Music (contexto, modelo) where

import Control.Applicative (Applicative, pure)
import Control.Monad       (Monad, join)
import Data.Bool           (otherwise)
import Data.Eq             ((==))
import Data.Foldable       (foldMap)
import Data.Function       (($), (.), id)
import Data.Functor        ((<$>), fmap)
import Data.Int            (Int)
import Data.List           (dropWhileEnd, null, tails)
import Data.Map            (Map, fromList, fromListWith, mapWithKey, lookup, intersectionWith, toList)
import Data.Maybe          (Maybe, fromJust, maybe)
import Data.Monoid         ((<>), Monoid, mappend, mempty)
import Data.Ord            ((<), Ord)
import Data.Tuple          (swap)
import GHC.Real            (denominator)
import Test.QuickCheck.Gen (Gen, unGen, frequency)
import Prelude             ((+), (*), (/), Fractional, Integer, Integral, Num, Rational, fromIntegral, lcm, pred, truncate)
import System.IO           (IO, getLine, print)
import System.Random       (StdGen, newStdGen)

import qualified Data.List as L (length, take)

length ∷ Num c ⇒ [a] →  c
length = fromIntegral . L.length

take ∷ Integral a ⇒ a → [a1] → [a1]
take = L.take . fromIntegral



tabular
  ∷ ∀ evento frecuencia. (Num frecuencia, Ord evento)
  ⇒ Integer → [evento] → Map [evento] frecuencia

tabular orden secuencia
  | orden == 0 = fromList [([], length secuencia)]
  | otherwise  = fromListWith (+) $ (, 1) <$> contextos
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

newtype LCM a = LCM {getLCM :: a}

instance Integral a => Monoid (LCM a) where
  mempty = LCM 1
  mappend izq der = LCM $ getLCM izq `lcm` getLCM der

iterateM :: (Monad m, Applicative m) => Int -> (e -> m e) -> e -> m [e]
iterateM 0 _ _ = pure []
iterateM n f e = do
  e' <- f e
  es <- iterateM (pred n) f e'
  pure (e:es)


generar ∷ Ord evento => ([evento] → Map [evento] Rational) → [evento] → Gen [evento]
generar modelito contexto
  = frequency
  . (fmap.fmap) pure
  . fmap swap
  . toList
  $ truncate . (fromIntegral l *) <$> t
  where
    l = getLCM $ foldMap LCM (GHC.Real.denominator <$> t)
    t = modelito contexto

modelo :: (Fractional probabilidad, Ord evento) => [evento] -> [evento] -> Map [evento] probabilidad
modelo secuencia = fromJust . probabilidades secuencia

composicion :: Ord a => [a] -> StdGen -> [a]
composicion secuencia generador = join $ unGen (iterateM 50 (generar $ modelo secuencia) []) generador 0

main ∷ IO ()
main
  = do
    sec ← getLine
    g   ← newStdGen
    print $ composicion sec g
