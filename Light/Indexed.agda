{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}
{-# OPTIONS --type-in-type #-}

-- Note: Using this module is discouraged unless absolutely necessary.
-- Use `Data.Product` or `Data.Both` instead.

module Light.Indexed where

open import Light.Level using (Level)

postulate ℓ : Level
record Indexed {aℓ} (𝕒 : Set aℓ) {aℓf : 𝕒 → Level} (𝕓 : ∀ a → Set (aℓf a)) : Set ℓ where
      constructor indexed
      field index : 𝕒
      field thing : 𝕓 index
open Indexed public
