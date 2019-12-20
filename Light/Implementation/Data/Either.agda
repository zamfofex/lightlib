{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Data.Either where

open import Light.Library.Data.Either using (Library ; Dependencies)
open import Light.Level using (_⊔_)
open import Light.Variable.Levels

instance dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record { Implementation }
      where
      module Implementation where
            ℓf : _
            ℓf = _⊔_
            data Either (𝕒 : Set aℓ) (𝕓 : Set bℓ) : Set (aℓ ⊔ bℓ) where
                  left : 𝕒 → Either 𝕒 𝕓
                  right : 𝕓 → Either 𝕒 𝕓
