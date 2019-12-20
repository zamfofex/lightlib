{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

open import Light.Library.Data.Natural as ℕ using (ℕ ; predecessor ; zero)
open import Light.Package using (Package)

module Light.Literals.Level ⦃ natural‐package : Package record { ℕ } ⦄ where

open import Light.Literals.Definition.Natural using (FromNatural)
open FromNatural using (convert)
open import Light.Level using (Level ; 0ℓ ; ++_)
open import Light.Library.Relation.Decidable using (if_then_else_)
open import Light.Library.Relation.Binary.Equality using (_≈_)
open import Light.Library.Relation.Binary.Equality.Decidable using (DecidableEquality)

instance from‐natural : FromNatural Level
convert from‐natural n =
      if n ≈ zero
      then 0ℓ
      else ++ convert from‐natural (predecessor n)
