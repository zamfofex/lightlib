{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Relation.Binary.Equality.Decidable where

open import Light.Library.Relation using (Base)
open import Light.Library.Relation.Binary.Equality using (Equality)
open import Light.Level using (Setω)
import Light.Library.Relation.Decidable as Decidable
open import Light.Package using (Package)
open import Light.Variable.Levels

record DecidableEquality (𝕒 : Set aℓ) (𝕓 : Set aℓ) : Setω where
      constructor wrap
      field ⦃ decidable‐package ⦄ : Package record { Decidable }
      field ⦃ equals ⦄ : Equality 𝕒 𝕓

DecidableSelfEquality : ∀ (𝕒 : Set aℓ) → Setω
DecidableSelfEquality 𝕒 = DecidableEquality 𝕒 𝕒

open DecidableEquality ⦃ ... ⦄ public
