{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Standard.Relation.Decidable where

open import Light.Variable.Sets
import Light.Implementation.Standard.Data.Empty
import Light.Implementation.Standard.Data.Unit
open import Light.Library.Data.Empty as Empty using (Empty)
open import Light.Library.Data.Unit as Unit using (Unit ; unit)
open import Light.Library.Relation.Decidable using (Library ; Dependencies)

instance dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record
      {
            Implementation ;
            to‐witness = λ ⦃ a ⦄ → Implementation.to‐witness a ;
            to‐false‐witness = λ ⦃ a ⦄ → Implementation.to‐false‐witness a ;
            from‐witness = λ ⦃ a ⦄ → Implementation.from‐witness a ;
            from‐false‐witness = λ ⦃ a ⦄ → Implementation.from‐false‐witness a
      }
      where
      module Implementation where
            open import Relation.Nullary using (yes ; no) renaming (Dec to Decidable) public
            open Relation.Nullary using (does)
            open import Function using (_∘_)
            import Data.Bool as Boolean
            open import Function using (id)
            open import Relation.Nullary.Decidable
                  renaming (
                        toWitness to to‐witness ;
                        fromWitness to from‐witness ;
                        toWitnessFalse to to‐false‐witness ;
                        fromWitnessFalse to from‐false‐witness
                  )
                  public
            open import Light.Implementation.Standard.Relation.Sets using (base) public
            
            ℓf = id
            
            if′_then_else_ : Decidable 𝕒 → 𝕓 → 𝕓 → 𝕓
            if′_then_else_ = Boolean.if_then_else_ ∘ does
            
            if_then_else_ :
                  ∀ (a : Decidable 𝕒)
                  → (∀ ⦃ witness : 𝕒 ⦄ → 𝕓)
                  → (∀ ⦃ witness : 𝕒 → Empty ⦄ → 𝕓)
                  → 𝕓
            if yes w then a else _ = a ⦃ witness = w ⦄
            if no w then _ else a = a ⦃ witness = w ⦄
            
            module Style where
                  open import Relation.Nullary.Decidable using (True ; False) public
                  open import Relation.Nullary.Negation using () renaming (¬? to ¬_) public
                  open import Relation.Nullary.Product using () renaming (_×-dec_ to _∧_) public
                  open import Relation.Nullary.Sum using () renaming (_⊎-dec_ to _∨_) public
                  open import Relation.Nullary.Implication using () renaming (_→-dec_ to _⇢_) public
                  
                  true : Decidable Unit
                  true = yes unit
                  
                  false : Decidable Empty
                  false = no λ ()
            
            style = record { Style }
