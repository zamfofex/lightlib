{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Relation.Decidable where

open import Light.Level using (Setω ; Level)
open import Light.Variable.Levels
open import Light.Variable.Sets
open import Light.Library.Relation using (Base ; Kind ; Style)
open import Light.Indexed using (Indexed ; thing ; indexed)
open import Light.Package using (Package)

record Dependencies : Setω where

record Library (dependencies : Dependencies) : Setω where
      field base : Base
      
      open Style (base .Base.style) using (True ; False)
      open Kind (base .Base.kind) using (Index ; Proposition)
      
      field
            ℓf : Index → Level
            Decidable : ∀ {i} → Proposition i → Set (ℓf i)
      kind : Kind
      kind = record { Index = Indexed Index Proposition ; Proposition = λ i → Decidable (thing i) }
      field
            instance style : Style kind
            if′_then_else_ : ∀ {i} {𝕒 : Proposition i} → Decidable 𝕒 → 𝕓 → 𝕓 → 𝕓
            if_then_else_ :
                  ∀ {i} {𝕒 : Proposition i}
                  → Decidable 𝕒
                  → (∀ ⦃ witness : True 𝕒 ⦄ → 𝕓)
                  → (∀ ⦃ witness : False 𝕒 ⦄ → 𝕓)
                  → 𝕓
            
            to‐witness : ∀ {i} {𝕒 : Proposition i} {a? : Decidable 𝕒} ⦃ truth : Style.True style a? ⦄ → True 𝕒
            to‐false‐witness : ∀ {i} {𝕒 : Proposition i} {a? : Decidable 𝕒} ⦃ falsehood : Style.False style a? ⦄ → False 𝕒
            
            ⦃ from‐witness ⦄ : ∀ {i} {𝕒 : Proposition i} {a? : Decidable 𝕒} ⦃ witness : True 𝕒 ⦄ → Style.True style a?
            ⦃ from‐false‐witness ⦄ : ∀ {i} {𝕒 : Proposition i} {a? : Decidable 𝕒} ⦃ witness : False 𝕒 ⦄ → Style.False style a?
            
            yes : ∀ {i} {𝕒 : Proposition i} → True 𝕒 → Decidable 𝕒
            no : ∀ {i} {𝕒 : Proposition i} → False 𝕒 → Decidable 𝕒
      instance base′ = record { kind = kind ; style = style }

open Library ⦃ ... ⦄ public
