{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Data.Unit where

open import Light.Level using (Level ; Setω)

record Dependencies : Setω where

record Library (dependencies : Dependencies) : Setω where
      field
            ℓ : Level
            Unit : Set ℓ
            unit : Unit
open Library ⦃ ... ⦄ public
