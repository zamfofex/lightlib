{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}
{-# OPTIONS --allow-unsolved-metas #-}


module Light.Implementation.Data.Product where

open import Light.Library.Data.Product using (Library ; Dependencies)
open import Light.Variable.Levels
open import Light.Level using (_⊔_)
open import Light.Library.Relation.Binary.Equality.Decidable using (DecidableEquality)
open import Light.Variable.Sets
open import Light.Library.Relation.Binary.Equality using (wrap)

instance dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record { Implementation }
      where
      module Implementation where
            record Σ (𝕒 : Set aℓ) (𝕓 : 𝕒 → Set bℓ) : Set (aℓ ⊔ bℓ) where
                  constructor both
                  field first : 𝕒
                  field second : 𝕓 first
            open Σ public
            
            equals :
                  ∀ ⦃ a‐c‐equals : DecidableEquality 𝕒 𝕔 ⦄ ⦃ b‐d‐equals : DecidableEquality 𝕓 𝕕 ⦄
                  → DecidableEquality (Σ 𝕒 (λ _ → 𝕓)) (Σ 𝕔 (λ _ → 𝕕))
            equals = {!!}
