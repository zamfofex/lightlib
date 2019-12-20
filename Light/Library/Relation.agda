{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Relation where

open import Light.Level using (Level ; Setω)
open import Light.Variable.Sets

record Kind : Setω where
      field
            iℓ : Level
            Index : Set iℓ
            ℓf : Index → Level
            Proposition : ∀ i → Set (ℓf i)

record Style (kind : Kind) : Setω where
      open Kind kind
      field
            true‐i false‐i : Index
            true : Proposition true‐i
            false : Proposition false‐i
            
            ¬‐index‐f : Index → Index
            ¬_ : ∀ {i} → Proposition i → Proposition (¬‐index‐f i)
            
            ∧‐index‐f ∨‐index‐f ⇢‐index‐f : Index → Index → Index
            _∧_ : ∀ {ia ib} → Proposition ia → Proposition ib → Proposition (∧‐index‐f ia ib)
            _∨_ : ∀ {ia ib} → Proposition ia → Proposition ib → Proposition (∨‐index‐f ia ib)
            _⇢_ : ∀ {ia ib} → Proposition ia → Proposition ib → Proposition (⇢‐index‐f ia ib)
            
            true‐set‐ℓf false‐set‐ℓf : Index → Level
            True : ∀ {i} → Proposition i → Set (true‐set‐ℓf i)
            False : ∀ {i} → Proposition i → Set (false‐set‐ℓf i)
            true‐is‐true : True true
            false‐is‐false : False false

record Base : Setω where
      field ⦃ kind ⦄ : Kind
      field ⦃ style ⦄ : Style kind

open Kind ⦃ ... ⦄ public
open Style ⦃ ... ⦄ public
