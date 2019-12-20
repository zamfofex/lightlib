{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}
{-# OPTIONS --allow-unsolved-metas #-}

module Light.Implementation.Standard.Data.Product where

open import Light.Library.Data.Product using (Library ; Dependencies)
open import Light.Library.Relation.Binary.Equality.Decidable using (DecidableEquality)
open import Light.Variable.Sets

instance dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record { Implementation }
      where
      module Implementation where
            open import Data.Product using (Σ) renaming (proj₁ to first ; proj₂ to second ; _,_ to both) public
            
            equals :
                  ∀ ⦃ a‐c‐equals : DecidableEquality 𝕒 𝕔 ⦄ ⦃ b‐d‐equals : DecidableEquality 𝕓 𝕕 ⦄
                  → DecidableEquality (Σ 𝕒 (λ _ → 𝕓)) (Σ 𝕔 (λ _ → 𝕕))
            equals = {!!}
