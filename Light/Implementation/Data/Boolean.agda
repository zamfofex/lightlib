{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}


module Light.Implementation.Data.Boolean where

open import Light.Library.Data.Boolean using (Library ; Dependencies)
open import Light.Variable.Sets
open import Light.Library.Data.Unit as Unit using (Unit ; unit)
open import Light.Level using (lift)
open import Light.Library.Relation.Decidable using (Decidable ; yes ; no)
open import Light.Library.Relation.Binary.Equality using (_≈_ ; wrap)
open import Light.Library.Relation.Binary using (reflexivity)
import Light.Implementation.Relation.Binary.Equality.Propositional
import Light.Implementation.Relation.Decidable
import Light.Package
import Light.Implementation.Relation.Binary.Equality.Propositional.Decidable as DecidablePropositional
import Light.Implementation.Data.Empty
import Light.Implementation.Data.Unit

instance dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record { Implementation }
      where
      module Implementation where
            data Boolean : Set where true false : Boolean
            
            {-# COMPILE JS
                  Boolean = (a, cons) => a ? cons.true() : cons.false()
            #-}
            {-# COMPILE JS true = !0 #-}
            {-# COMPILE JS false = !1 #-}
            
            -- TODO: Optimize operations using JS operators.
            
            if_then_else_ : Boolean → 𝕒 → 𝕒 → 𝕒
            if true then a else _ = a
            if false then _ else a = a
            
            postulate ¬_ : Boolean → Boolean
            postulate _∧_ _∨_ _⇢_ : Boolean → Boolean → Boolean
            
            true‐is‐true = lift unit
            false‐is‐false = lift unit
            
            private _≈?_ : ∀ (a b : Boolean) → Decidable (a ≈ b)
            false ≈? false = yes reflexivity
            false ≈? true = no λ ()
            true ≈? false = no λ ()
            true ≈? true = yes reflexivity
            
            equals = record { equals = wrap (record { are = λ a b → a ≈? b }) }
            
            module EqualityProperties = DecidablePropositional.Main _≈?_
