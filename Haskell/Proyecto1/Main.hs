{-
  Modulo: Main

  Adaptado del módulo Main dado por el prof Carlos Gómez por:
  Gabriela Limonta 10-10385
  John Delgado     10-10196
-}
module Main where

import Control.Applicative (pure)
import Prelude hiding (init)
import Input
import Euterpea hiding (Event)
import Data.List
import Data.Function
import Data.Functor
import System.Random       (newStdGen)

import qualified Music (composición, distancia, modelo, tabular)

-- Directorio predeterminado
directorio :: String
directorio = "./xml/"

-- Longitud de las secuencias musicales generadas
longitud :: Int
longitud = 50

{- Induce un modelo de contexto a partir de la colección musical
   en el directorio por defecto, genera una secuencia musical
   nueva a partir de este modelo, la imprime por pantalla y la
   reproduce.
   -}
componer :: IO ()
componer = componer' directorio

componer' :: String -> IO ()
componer' dir = do
  (seqs, filenames) <- loadMusicXmls dir
  generador <- newStdGen
  let
    secuencia = concat seqs
    modelo = Music.modelo secuencia
    composición = Music.composición longitud secuencia generador
  putStrLn $ show composición
  play $ sequenceToMusic composición

{- Recupera las diez secuencias más similares a la k-ésima secuencia
   de la colección musical en el directorio por defecto, donde la
   colección musical ha sido ordenada en orden alfabético por el
   nombre de archivo. Imprime una lista ordenada de las diez
   secuencias más similares. En cada fila de la lista se debe indicar
   el número de la secuencia (relativo al orden alfabético de la
   colección), el nombre de archivo y la distancia a la consulta.
   -}
buscar :: Int -> IO ()
buscar = buscar' directorio

buscar' :: String -> Int -> IO ()
buscar' dir n = do
  seqfns <- loadMusicXmls dir
  let seqfns_ordenados@(seqs, filenames) = unzip $ sortBy (compare `on` snd) $ (uncurry zip) seqfns
  if (n > 0) && (n <= length seqs)
    then
      let
        (a, (pos, (secuenciaOrigen, _)):bs) = splitAt n $ zip [1..] $ uncurry zip $ seqfns_ordenados
        otras = a ++ bs
        f (pos, (secuencia, nombre))
          = (d, show pos ++ "\t" ++ nombre ++ "\t" ++ show d)
          where
            d = Music.distancia (Music.tabular 1 secuencia) (Music.tabular 1 secuenciaOrigen)
      in putStrLn $ unlines $ fmap snd $ take 10 $ sortBy (compare `on` fst) $ f <$> otras
    else
      putStrLn "Indice fuera de rango"

tocar :: Int -> IO ()
tocar n = do
  seqfns <- loadMusicXmls directorio
  let (seqs, filenames) = unzip $ sortBy (compare `on` snd) $ (uncurry zip) seqfns
  if (n > 0) && (n <= length seqs) then
    putStrLn (filenames !! (n-1)) >>
    play (sequenceToMusic (seqs !! (n-1)))
    else
      putStrLn "Indice fuera de rango"

eventToNote :: Evento -> Music Note1
eventToNote e = note
  where
  d = (fromIntegral $ snd e) / 16
  p = Euterpea.pitch $ fst e
  note = Prim (Note d (p,[]))

sequenceToMusic :: [Evento] -> Music Note1
sequenceToMusic es = line $ map eventToNote es

main :: IO ()
main
  = do
    componer' "xml/"
