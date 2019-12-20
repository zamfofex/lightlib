{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Data.Both where

open import Light.Level using (Level ; Setω)
open import Light.Variable.Sets
open import Light.Variable.Levels
open import Light.Library.Relation.Binary
      using (SelfTransitive ; SelfSymmetric ; Reflexive)
open import Light.Library.Relation.Binary.Equality.Decidable using (DecidableEquality ; DecidableSelfEquality)

record Dependencies : Setω where

record Library (dependencies : Dependencies) : Setω where
      field
            ℓf : Level → Level → Level
            Both : Set aℓ → Set bℓ → Set (ℓf aℓ bℓ)
            both : 𝕒 → 𝕓 → Both 𝕒 𝕓
            first : Both 𝕒 𝕓 → 𝕒
            second : Both 𝕒 𝕓 → 𝕓
            ⦃ equals ⦄ :
                  ∀ ⦃ a‐c‐equals : DecidableEquality 𝕒 𝕔 ⦄ ⦃ b‐d‐equals : DecidableEquality 𝕓 𝕕 ⦄
                  → DecidableEquality (Both 𝕒 𝕓) (Both 𝕔 𝕕)

open Library ⦃ ... ⦄ public
