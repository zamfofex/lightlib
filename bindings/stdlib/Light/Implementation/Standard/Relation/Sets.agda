{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Standard.Relation.Sets where

open import Light.Level using (_⊔_)
open import Light.Variable.Levels
open import Light.Variable.Sets
open import Light.Library.Relation using (Base ; Kind ; Style)
open import Light.Library.Data.Unit as Unit using (Unit ; unit)
open import Light.Library.Data.Empty as Empty using (Empty)
open import Light.Library.Data.Both as Both using (Both)
import Light.Library.Data.Product as Product
open import Light.Library.Data.These as These using (These)
import Light.Implementation.Standard.Data.Unit
import Light.Implementation.Standard.Data.Empty
import Light.Implementation.Standard.Data.Product
import Light.Implementation.Standard.Data.These

instance kind : Kind
kind = record { Proposition = λ ℓ → Set ℓ }

instance style : Style kind
style = record { Implementation }
      where
      module Implementation where
            true = Unit
            false = Empty
            
            ¬_ : Set ℓ → Set ℓ
            ¬ 𝕒 = 𝕒 → Empty
            
            _∧_ = Both
            _∨_ = These
            
            _⇢_ : Set aℓ → Set bℓ → Set (aℓ ⊔ bℓ)
            𝕒 ⇢ 𝕓 = 𝕒 → 𝕓
            
            True : Set ℓ → Set ℓ
            True 𝕒 = 𝕒
            False = ¬_
            
            true‐is‐true = unit
            false‐is‐false : _
            false‐is‐false ()

instance base : Base
base = record { kind = kind ; style = style }
