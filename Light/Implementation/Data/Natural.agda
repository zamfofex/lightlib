{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Data.Natural where

open import Light.Library.Data.Natural using (Library ; Dependencies)
import Light.Implementation.Relation.Decidable
import Light.Implementation.Relation.Binary.Equality.Propositional
import Light.Package
open import Light.Library.Relation.Decidable using (Decidable ; yes ; no ; if_then_else_)
import Light.Implementation.Relation.Binary.Equality.Propositional.Decidable as DecidablePropositional
open import Light.Library.Relation.Binary using (reflexivity ; congruence)
open import Light.Library.Relation.Binary.Equality using (_≈_ ; wrap)
open import Agda.Builtin.Equality using (refl)

instance dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record { Implementation }
      where
      module Implementation where
            data ℕ : Set where
                  zero : ℕ
                  successor : ℕ → ℕ
            
            {-# COMPILE JS
                  ℕ = (a, cons) => a === 0n ? cons.zero() : cons.successor(a - 1n)
            #-}
            {-# COMPILE JS zero = 0n #-}
            {-# COMPILE JS successor = a => a + 1n #-}
            
            postulate _+_ _∗_ _//_ _∸_ : ℕ → ℕ → ℕ
            
            {-# COMPILE JS _+_ = () => a => b => a + b #-}
            {-# COMPILE JS _∗_ = () => a => b => a * b #-}
            {-# COMPILE JS _//_ = () => a => b => a / b #-}
            {-# COMPILE JS _∸_ = () => a => b => a < b ? 0n : a - b #-}
            
            predecessor : _
            predecessor a = a ∸ successor zero
            
            private _≈?_ : ∀ (a b : ℕ) → Decidable (a ≈ b)
            zero ≈? zero = yes reflexivity
            successor _ ≈? zero = no λ ()
            zero ≈? successor _ = no λ ()
            successor a ≈? successor b =
                  if a ≈? b
                  then (λ ⦃ a‐≡‐b ⦄ → yes (congruence a‐≡‐b))
                  else (λ ⦃ f ⦄ → no λ {refl → f reflexivity})
            
            equals = record { equals = wrap (record { are = λ a b → a ≈? b }) }
            
            module EqualityProperties = DecidablePropositional.Main _≈?_
