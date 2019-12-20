{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Literals.Definition.Natural where

open import Light.Library.Data.Natural as ℕ using (ℕ ; zero ; successor) renaming (ℓ to nℓ)
open import Light.Level using (++_ ; _⊔_)
open import Light.Variable.Sets
open import Light.Variable.Levels
open import Light.Package using (Package)

record FromNatural ⦃ package : Package record { ℕ } ⦄ (𝕒 : Set ℓ) : Set (++ (nℓ ⊔ ℓ)) where
      field convert : ℕ → 𝕒

open FromNatural ⦃ ... ⦄ using (convert)
open import Agda.Builtin.Nat as Nat using (Nat)

private
      change : ∀ ⦃ package : Package record { ℕ } ⦄ → Nat → ℕ
      change Nat.zero = zero
      change (Nat.suc n) = successor (change n)

from‐literal : ∀ ⦃ package : Package record { ℕ } ⦄ ⦃ natural : FromNatural 𝕒 ⦄ (n : Nat) → 𝕒
from‐literal n = convert (change n)
{-# BUILTIN FROMNAT from‐literal #-}
