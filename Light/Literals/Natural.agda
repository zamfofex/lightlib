{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

open import Light.Library.Data.Natural as ℕ using (ℕ)
open import Light.Package using (Package)

module Light.Literals.Natural ⦃ package : Package record { ℕ } ⦄ where

open import Light.Literals.Definition.Natural using (FromNatural)
open FromNatural using (convert)

instance from‐natural : FromNatural ℕ
convert from‐natural n = n
