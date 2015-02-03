{-# LANGUAGE TypeOperators #-}
module Main where

import Data.Word (Word8)

import KMC.Expression
import KMC.FSTConstruction
import KMC.Syntax.Config
import KMC.Syntax.Parser
import KMC.OutputTerm
import KMC.RangeSet
import KMC.SSTConstruction
import KMC.SymbolicSST
import KMC.Theories

sstFromFancy :: (Bounded sigma, Enum sigma, Ord sigma) =>
                String
                -> SST (PathTree Var Int)
                       (RangeSet sigma)
                       (Join
                         (Const sigma [Bool] :+: Enumerator (RangeSet sigma) sigma Bool)
                         [Bool])
                       Var
sstFromFancy str =
  case parseRegex fancyRegexParser str of
    Left e -> error e
    Right (_, re) -> sstFromFST $ fromMu $ fromRegex re

runSST :: String -> [Char] -> Stream [Bool]
runSST str = run (sstFromFancy str)

main :: IO ()
main = return ()
