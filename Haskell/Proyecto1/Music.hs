{-
  Modulo: Music

  Modulo que ayuda el manejo de secuencias de eventos.
  (Calcular distancia entre secuencias, componer secuencias nuevas)

  Autores:
  Gabriela Limonta 10-10385
  John Delgado     10-10196
-}

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

{-
  Definimos un length y un take para las listas que nos permita
  ahorrarnos problemas de tipos numéricos.
-}
length ∷ Num c ⇒ [a] →  c
length = fromIntegral . L.length

take ∷ Integral a ⇒ a → [a1] → [a1]
take = L.take . fromIntegral



-- Tabular se encarga de generar un modelo de contexto de un orden determinado dada una secuencia.
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


{-
   Probabilidades toma una secuencia y un contexto y devuelve un map que asocia el
   proximo evento con la probabilidad de que suceda.
   Probabilidades solo se llama con contextos pertenecientes a la secuencia, nunca con algún otro.
-}
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



-- Nuevo tipo para calcular el minimo comun multiplo de un numero
newtype LCM a = LCM { getLCM ∷ a }

instance Integral a ⇒ Monoid (LCM a) where
  mempty = LCM 1
  mappend izq der = LCM $ getLCM izq `lcm` getLCM der

{-
  Toma una funcion y un elemento al que aplicar esa funcion e itera
  tantas veces sea indicado sobre esto generando una lista que luego
  genera un computo monadico.
-}

iterateM ∷ (Monad m, Applicative m) ⇒ Int → (e → m e) → e → m [e]
iterateM 0 _ _ = pure []
iterateM n f e = do
  e' ← f e
  es ← iterateM (pred n) f e'
  pure (e:es)


{-
   Generar toma un modelo y un contexto y devuelve un mapa que asocia el contexto dado con
   otro mapa que tiene la asociacion entre los distintos eventos que pueden ocurrir y la
   probabilidad de que ocurran. Por cada llamada se genera una entrada en el map con todas
   las posibilidades para ese contexto.
-}
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

{-
   Representa el modelo de probabilidad de una secuencia dada. Toma una secuencia y genera el mapa
   asociativo entre los contextos y la asociacion entre los eventos posibles y su probabilidad de ocurrir.
-}
modelo ∷ (Fractional probabilidad, Ord evento) ⇒ [evento] → Map [evento] (Map [evento] probabilidad)
modelo secuencia = insert [] simples $ mapWithKey (const . probabilidades secuencia) simples
  where
    simples = (tabular 1 secuencia)

{-
   Composición se encarga de componer una nueva secuencia musical de longitud dada y semejante a una secuencia
   dada también.
-}
composición ∷ Ord evento ⇒ Int → [evento] → StdGen → [evento]
composición longitud secuencia generador = join $ unGen (iterateM longitud (generar $ modelo secuencia) []) generador 0

{-
   Distancia se encarga de calcular la distancia entre dos modelos de  contexto que representan a dos secuencias distintas.
-}
distancia ∷ (Ord evento, Floating frecuencia) ⇒ Map [evento] frecuencia → Map [evento] frecuencia → frecuencia
distancia a b = sqrt $ getSum $ foldMap Sum $ (** 2) <$> unionWith (-) b a

{-
   Main de prueba para el módulo, se puede probar el modulo solo descomentando esta parte del codigo
-}
{-
main ∷ IO ()
main
  = do
    sec ← getLine
    g   ← newStdGen
    print $ composición 10 sec g
-}
