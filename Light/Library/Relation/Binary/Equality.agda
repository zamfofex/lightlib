{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Relation.Binary.Equality where

open import Light.Library.Relation.Binary using (Binary ; SelfBinary)
open import Light.Library.Relation using (Base)
open import Light.Variable.Levels
open import Light.Level using (Setω)
open import Light.Variable.Sets

-- Binary relation wrapper for equality. (Purely conventional.)
-- (To facilitate instance lookup.)

record Equality ⦃ base : Base ⦄ (𝕒 : Set aℓ) (𝕓 : Set bℓ) : Setω where
      constructor wrap
      field relation : Binary 𝕒 𝕓
      open Binary relation using () renaming (are to _≈_) public

SelfEquality : ∀ ⦃ base : Base ⦄ → Set aℓ → Setω
SelfEquality 𝕒 = Equality 𝕒 𝕒

open Equality ⦃ ... ⦄ using (_≈_) public
private module Eq = Equality ⦃ ... ⦄

relation : ∀ (𝕒 : Set aℓ) (𝕓 : Set bℓ) ⦃ base : Base ⦄ ⦃ equals : Equality 𝕒 𝕓 ⦄ → Binary 𝕒 𝕓
relation _ _ = Eq.relation

self‐relation : ∀ (𝕒 : Set aℓ) ⦃ base : Base ⦄ ⦃ equals : SelfEquality 𝕒 ⦄ → SelfBinary 𝕒
self‐relation _ = Eq.relation
