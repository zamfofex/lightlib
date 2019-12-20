{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Data.Either where

open import Light.Level using (Level ; Setω ; _⊔_)
open import Light.Variable.Sets
open import Light.Variable.Levels

record Dependencies : Setω where

record Library (dependencies : Dependencies) : Setω where
      field
            ℓf : Level → Level → Level
            Either : Set aℓ → Set bℓ → Set (ℓf aℓ bℓ)
            left : 𝕒 → Either 𝕒 𝕓
            right : 𝕓 → Either 𝕒 𝕓
open Library ⦃ ... ⦄ public
