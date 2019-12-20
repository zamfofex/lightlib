{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Data.Product where

open import Light.Level using (Level ; Setω)
open import Light.Variable.Sets
open import Light.Variable.Levels
import Light.Library.Data.Both as Both
open import Light.Library.Relation.Binary
      using (SelfTransitive ; SelfSymmetric ; Reflexive)
open import Light.Library.Relation.Binary.Equality.Decidable using (DecidableEquality)

record Dependencies : Setω where

record Library (dependencies : Dependencies) : Setω where
      field
            ℓf : Level → Level → Level
            Σ : ∀ (𝕒 : Set aℓ) → (𝕒 → Set bℓ) → Set (ℓf aℓ bℓ)
            both : ∀ {𝕓 : 𝕒 → Set bℓ} a (b : 𝕓 a) → Σ 𝕒 𝕓
            first : ∀ {𝕓 : 𝕒 → Set bℓ} → Σ 𝕒 𝕓 → 𝕒
            second : ∀ {𝕓 : 𝕒 → Set bℓ} (product : Σ 𝕒 𝕓) → 𝕓 (first product)
            ⦃ equals ⦄ :
                  ∀ ⦃ a‐c‐equals : DecidableEquality 𝕒 𝕔 ⦄ ⦃ b‐d‐equals : DecidableEquality 𝕓 𝕕 ⦄
                  → DecidableEquality (Σ 𝕒 (λ _ → 𝕓)) (Σ 𝕔 (λ _ → 𝕕))
      
      ∃ : ∀ {𝕒 : Set aℓ} → (𝕒 → Set bℓ) → Set (ℓf aℓ bℓ)
      ∃ = Σ _
      
      instance both‐library : Both.Library record {}
      both‐library = record
            {
                  Both = λ 𝕒 𝕓 → Σ 𝕒 (λ _ → 𝕓) ;
                  ℓf = ℓf ;
                  both = both ;
                  first = first ;
                  second = second ;
                  equals = equals
            }

open Library ⦃ ... ⦄ public
