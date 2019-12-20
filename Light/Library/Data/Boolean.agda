{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Data.Boolean where

open import Light.Level using (Level ; Setω ; Lifted)
open import Light.Variable.Sets
open import Light.Library.Data.Unit as Unit using (Unit)
open import Light.Library.Data.Empty as Empty using (Empty)
open import Light.Package using (Package)
open import Light.Library.Relation.Binary
      using (SelfTransitive ; SelfSymmetric ; Reflexive)
open import Light.Library.Relation.Binary.Equality as ≈ using (_≈_)
open import Light.Library.Relation.Binary.Equality.Decidable using (DecidableSelfEquality)
import Light.Library.Relation.Decidable
open import Light.Library.Relation using (False)

record Dependencies : Setω where
      field
            ⦃ unit‐package ⦄ : Package record { Unit }
            ⦃ empty‐package ⦄ : Package record { Empty }

record Library (dependencies : Dependencies) : Setω where
      field
            ℓ : Level
            Boolean : Set ℓ
            true false : Boolean
            if_then_else_ : Boolean → 𝕒 → 𝕒 → 𝕒
            ¬_ : Boolean → Boolean
            _∧_ _∨_ _⇢_ : Boolean → Boolean → Boolean
            true‐is‐true : if true then Lifted (Empty.ℓ) Unit else Lifted (Unit.ℓ) Empty
            false‐is‐false : if false then Lifted (Unit.ℓ) Empty else Lifted (Empty.ℓ) Unit
            ⦃ equals ⦄ : DecidableSelfEquality Boolean
            ⦃ ≈‐transitive ⦄ : SelfTransitive (≈.self‐relation Boolean)
            ⦃ ≈‐symmetric ⦄ : SelfSymmetric (≈.self‐relation Boolean)
            ⦃ ≈‐reflexive ⦄ : Reflexive (≈.self‐relation Boolean)
            true‐≉‐false : False (true ≈ false)

open Library ⦃ ... ⦄ public
