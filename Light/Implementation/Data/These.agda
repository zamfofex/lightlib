{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Data.These where

open import Light.Library.Data.These using (Library ; Dependencies)
open import Light.Variable.Levels
open import Light.Level using (_⊔_)

dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record { Implementation }
      where
      module Implementation where
            data These (𝕒 : Set aℓ) (𝕓 : Set bℓ) : Set (aℓ ⊔ bℓ) where
                  this : 𝕒 → These 𝕒 𝕓
                  that : 𝕓 → These 𝕒 𝕓
                  these : 𝕒 → 𝕓 → These 𝕒 𝕓
