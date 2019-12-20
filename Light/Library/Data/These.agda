{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Data.These where

open import Light.Level using (Setω ; Level)
open import Light.Variable.Levels
open import Light.Variable.Sets

record Dependencies : Setω where

record Library (dependencies : Dependencies) : Setω where
      field
            ℓf : Level → Level → Level
            These : Set aℓ → Set bℓ → Set (ℓf aℓ bℓ)
            this : 𝕒 → These 𝕒 𝕓
            that : 𝕓 → These 𝕒 𝕓
            these : 𝕒 → 𝕓 → These 𝕒 𝕓
open Library ⦃ ... ⦄ public
