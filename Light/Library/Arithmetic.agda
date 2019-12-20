{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Arithmetic where

open import Light.Level using (Setω ; Level)
open import Light.Variable.Levels

record Arithmetic (Operand : Set ℓ) : Setω where
      field _+_ _∗_ : Operand → Operand → Operand
open Arithmetic ⦃ ... ⦄ public
