{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Subtyping where

open import Light.Level using (_⊔_ ; ++_)
open import Light.Variable.Levels
open import Light.Variable.Sets

record DirectSubtyping (𝕒 : Set aℓ) (𝕓 : Set bℓ) : Set (aℓ ⊔ bℓ) where
      constructor #_
      field cast₁ : 𝕒 → 𝕓
open DirectSubtyping ⦃ ... ⦄ public

record StrictSubtyping (𝕒 : Set aℓ) (𝕓 : Set aℓ) : Set (++ aℓ)
data Subtyping {aℓ} : ∀ (𝕒 : Set aℓ) (𝕓 : Set aℓ) → Set (++ aℓ)

record StrictSubtyping {aℓ} 𝕒 𝕓 where
      inductive
      instance constructor transitivity′
      field {Thing} : Set aℓ
      field ⦃ direct ⦄ : DirectSubtyping 𝕒 Thing
      field ⦃ indirect ⦄ : Subtyping Thing 𝕓

data Subtyping where
      instance reflexivity : Subtyping 𝕒 𝕒
      instance from‐strict : ∀ ⦃ strict : StrictSubtyping 𝕒 𝕓 ⦄ → Subtyping 𝕒 𝕓

cast : ∀ ⦃ subtyping : Subtyping 𝕒 𝕓 ⦄ → 𝕒 → 𝕓
cast ⦃ subtyping = reflexivity ⦄ a = a
cast ⦃ subtyping = from‐strict ⦄ a = cast (cast₁ a)

-- Note: These cannot be instances, they must be written explicitly.
transitivity′′ : ∀ ⦃ a‐to‐b : Subtyping 𝕒 𝕓 ⦄ ⦃ b‐to‐c : Subtyping 𝕓 𝕔 ⦄ → DirectSubtyping 𝕒 𝕔
transitivity′′ ⦃ a‐to‐b = a‐to‐b ⦄ ⦃ b‐to‐c = b‐to‐c ⦄ = # λ a → cast ⦃ subtyping = b‐to‐c ⦄ (cast ⦃ subtyping = a‐to‐b ⦄ a)
transitivity : ∀ ⦃ a‐to‐b : Subtyping 𝕒 𝕓 ⦄ ⦃ b‐to‐c : Subtyping 𝕓 𝕔 ⦄ → Subtyping 𝕒 𝕔
transitivity ⦃ a‐to‐b = a‐to‐b ⦄ ⦃ b‐to‐c = b‐to‐c ⦄ = from‐strict where instance _ = transitivity′′ ⦃ a‐to‐b = a‐to‐b ⦄ ⦃ b‐to‐c = b‐to‐c ⦄

module _ ⦃ c‐to‐a : Subtyping 𝕔 𝕒 ⦄ ⦃ b‐to‐d : Subtyping 𝕓 𝕕 ⦄ where
      instance
            explicit‐variance : DirectSubtyping (𝕒 → 𝕓) (𝕔 → 𝕕)
            implicit‐variance : DirectSubtyping (∀ {a : 𝕒} → 𝕓) (∀ {c : 𝕔} → 𝕕)
            instance‐variance : DirectSubtyping (∀ ⦃ a : 𝕒 ⦄ → 𝕓) (∀ ⦃ c : 𝕔 ⦄ → 𝕕)
      explicit‐variance = # λ f c → cast ⦃ subtyping = b‐to‐d ⦄ (f (cast c))
      implicit‐variance = # λ f {c = c} → cast ⦃ subtyping = b‐to‐d ⦄ (f {a = cast c})
      instance‐variance = # λ f ⦃ c = c ⦄ → cast ⦃ subtyping = b‐to‐d ⦄ (f ⦃ a = cast c ⦄)
