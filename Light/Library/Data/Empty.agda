{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Data.Empty where

open import Light.Level using (Level ; Setω)
open import Light.Variable.Sets

record Dependencies : Setω where

record Library (dependencies : Dependencies) : Setω where
      field
            ℓ : Level
            Empty : Set ℓ
            eliminate : Empty → 𝕒
open Library ⦃ ... ⦄ public
