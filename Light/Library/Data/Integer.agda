{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Data.Integer where

open import Light.Level using (Level ; Setω)
open import Light.Library.Data.Empty as Empty using (Empty)
open import Light.Library.Data.Natural as Natural using (ℕ)
open import Light.Subtyping using (DirectSubtyping ; #_)
open import Light.Library.Arithmetic using (Arithmetic)
open import Light.Package using (Package)
open import Light.Library.Relation.Binary
      using (SelfTransitive ; SelfSymmetric ; Reflexive)
open import Light.Library.Relation.Binary.Equality as ≈ using (_≈_)
open import Light.Library.Relation.Binary.Equality.Decidable using (DecidableSelfEquality)
import Light.Library.Relation.Decidable

record Dependencies : Setω where
      field ⦃ natural‐package ⦄ : Package record { Natural }

record Library (dependencies : Dependencies) : Setω where
      field
            ℓ ≈ℓ : Level
            ℤ : Set ℓ
            zero : ℤ
            successor : ℤ → ℤ
            predecessor : ℤ → ℤ
            _+_ : ℤ → ℤ → ℤ
            _∗_ : ℤ → ℤ → ℤ
            _//_ : ℤ → ℤ → ℤ
            _−_ : ℤ → ℤ → ℤ
            −_ : ℤ → ℤ
            from‐natural : ℕ → ℤ
            ⦃ equals ⦄ : DecidableSelfEquality ℤ
            ⦃ ≈‐transitive ⦄ : SelfTransitive (≈.self‐relation ℤ)
            ⦃ ≈‐symmetric ⦄ : SelfSymmetric (≈.self‐relation ℤ)
            ⦃ ≈‐reflexive ⦄ : Reflexive (≈.self‐relation ℤ)
      
      instance naturals‐are‐integers : DirectSubtyping ℕ ℤ
      naturals‐are‐integers = # from‐natural
      
      instance arithmetic : Arithmetic ℤ
      arithmetic = record { _+_ = _+_ ; _∗_ = _∗_ }

open Library ⦃ ... ⦄ public
