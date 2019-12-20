{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Data.Natural where

open import Light.Level using (Level ; Setω)
open import Light.Library.Arithmetic using (Arithmetic)
open import Light.Package using (Package)
open import Light.Library.Relation.Binary
      using (SelfTransitive ; SelfSymmetric ; Reflexive)
open import Light.Library.Relation.Binary.Decidable using (DecidableSelfBinary)
import Light.Library.Relation.Decidable
open import Light.Library.Relation.Binary.Equality as ≈ using (_≈_)
open import Light.Library.Relation.Binary.Equality.Decidable using (DecidableSelfEquality)
open import Light.Library.Relation using (False)

record Dependencies : Setω where

record Library (dependencies : Dependencies) : Setω where
      field
            ℓ : Level
            ℕ : Set ℓ
            ⦃ equals ⦄ : DecidableSelfEquality ℕ
            zero : ℕ
            successor : ℕ → ℕ
            predecessor : ∀ (a : ℕ) ⦃ a‐≉‐0 : False (a ≈ zero) ⦄ → ℕ
            _+_ _∗_ _//_ _∸_ : ℕ → ℕ → ℕ
            ⦃ ≈‐transitive ⦄ : SelfTransitive (≈.self‐relation ℕ)
            ⦃ ≈‐symmetric ⦄ : SelfSymmetric (≈.self‐relation ℕ)
            ⦃ ≈‐reflexive ⦄ : Reflexive (≈.self‐relation ℕ)
      
      instance arithmetic : Arithmetic ℕ
      arithmetic = record { _+_ = _+_ ; _∗_ = _∗_ }
open Library ⦃ ... ⦄ public
