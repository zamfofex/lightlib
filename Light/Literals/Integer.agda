{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

open import Light.Library.Data.Integer as ℤ using (ℤ ; zero ; successor)
open import Light.Package using (Package)

module Light.Literals.Integer ⦃ package : Package record { ℤ } ⦄ where

open import Light.Literals.Definition.Natural using (FromNatural)
open import Light.Literals.Definition.Negative using (FromNegative)
open FromNatural using (convert)
open import Light.Library.Relation.Decidable using (if_then_else_)
open import Light.Library.Relation.Binary.Equality using (_≈_)
import Light.Library.Data.Natural as ℕ

import Light.Library.Relation.Binary.Equality.Decidable
instance from‐natural : FromNatural ℤ
convert from‐natural n =
      if n ≈ ℕ.zero
      then zero
      else successor (convert from‐natural (ℕ.predecessor n))
