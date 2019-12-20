{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

import Light.Library.Relation.Decidable as Decidable
open import Light.Package using (Package)

module Light.Library.Relation.Binary.Decidable where

open import Light.Library.Relation.Binary using (Binary)
open import Light.Level using (Setω)

module _ ⦃ decidable‐package : Package record {Decidable} ⦄ where
      DecidableBinary : Setω
      DecidableBinary = ∀ {aℓ bℓ} (𝕒 : Set aℓ) (𝕓 : Set bℓ) → Binary 𝕒 𝕓
      
      DecidableSelfBinary : Setω
      DecidableSelfBinary = ∀ {aℓ} (𝕒 : Set aℓ) → Binary 𝕒 𝕒
