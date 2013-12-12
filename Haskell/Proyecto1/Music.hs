{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE UnicodeSyntax #-}

module Music (composición, distancia, modelo, tabular) where

import Control.Applicative (Applicative, pure)
import Control.Monad       (Monad, join)
import Data.Bool           (otherwise)
import Data.Eq             ((==))
import Data.Foldable       (foldMap)
import Data.Function       (($), (.), const, id)
import Data.Functor        ((<$>), fmap)
import Data.Int            (Int)
import Data.List           (dropWhileEnd, null, tails)
import Data.Map            (Map, fromList, fromListWith, insert, mapWithKey, lookup, intersectionWith, toList, unionWith)
import Data.Maybe          (Maybe, fromJust, maybe)
import Data.Monoid         ((<>), Monoid, Sum(Sum, getSum), mappend, mempty)
import Data.Ord            ((<), Ord)
import Data.Tuple          (swap)
import GHC.Real            (denominator)
import Test.QuickCheck.Gen (Gen, unGen, frequency)
import Prelude             ((+), (-), (*), (**), (/), Floating, Fractional, Integer, Integral, Num, Rational, fromIntegral, lcm, pred, sqrt, truncate)
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



-- Ojo nunca llames a esta mierda con una vaina que no sea un evento de ehh...
probabilidades
  ∷ ∀ evento probabilidad. (Fractional probabilidad, Ord evento)
  ⇒ [evento] → [evento] → Map [evento] probabilidad

probabilidades secuencia contexto
  = if null contexto
    then simples
    else simples .+ condicionales frecuenciaContexto
  where
    frecuenciaContexto = fromJust $ lookup contexto tabla1
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



newtype LCM a = LCM { getLCM ∷ a }

instance Integral a ⇒ Monoid (LCM a) where
  mempty = LCM 1
  mappend izq der = LCM $ getLCM izq `lcm` getLCM der

iterateM ∷ (Monad m, Applicative m) ⇒ Int → (e → m e) → e → m [e]
iterateM 0 _ _ = pure []
iterateM n f e = do
  e' ← f e
  es ← iterateM (pred n) f e'
  pure (e:es)


-- nunca le pases un contexto que no esté o.. REPTAAAAAR (y pau pau :C)
generar ∷ Ord evento ⇒ (Map [evento] (Map [evento] Rational)) → [evento] → Gen [evento]
generar modelito contexto
  = frequency
  . (fmap.fmap) pure
  . fmap swap
  . toList
  $ truncate . (fromIntegral l *) <$> t
  where
    l = getLCM $ foldMap LCM (GHC.Real.denominator <$> t)
    t = fromJust $ lookup contexto modelito

modelo ∷ (Fractional probabilidad, Ord evento) ⇒ [evento] → Map [evento] (Map [evento] probabilidad)
modelo secuencia = insert [] simples $ mapWithKey (const . probabilidades secuencia) simples
  where
    simples = (tabular 1 secuencia)

composición ∷ Ord evento ⇒ Int → [evento] → StdGen → [evento]
composición longitud secuencia generador = join $ unGen (iterateM longitud (generar $ modelo secuencia) []) generador 0


distancia ∷ (Ord evento, Floating frecuencia) ⇒ Map [evento] frecuencia → Map [evento] frecuencia → frecuencia
distancia a b = sqrt $ getSum $ foldMap Sum $ (** 2) <$> unionWith (-) b a


main ∷ IO ()
main
  = do
    sec ← getLine
    g   ← newStdGen
    print $ composición 10 sec g
