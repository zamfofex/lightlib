{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}
{-# OPTIONS --allow-unsolved-metas #-}

module Light.Implementation.Relation.Decidable where

open import Light.Variable.Levels
open import Light.Variable.Sets
open import Light.Library.Relation.Decidable using (Library ; Dependencies)
open import Light.Library.Data.Empty as Empty using (Empty)
open import Light.Library.Data.Unit as Unit using (Unit ; unit)
open import Light.Library.Data.Both as Both using (Both)
import Light.Library.Data.Product as Product
open import Light.Library.Data.These as These using (These)
import Light.Implementation.Data.Empty
import Light.Implementation.Data.Unit
import Light.Implementation.Data.Product
import Light.Implementation.Data.These
import Light.Package

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
            open import Light.Implementation.Relation.Sets using (base) public
            
            data Decidable (𝕒 : Set ℓ) : Set ℓ where
                  yes : 𝕒 → Decidable 𝕒
                  no : (𝕒 → Empty) → Decidable 𝕒
            
            module Style where
                  true : Decidable Unit
                  true = yes unit
                  
                  false : Decidable Empty
                  false = no λ a → a
                  
                  ¬_ : Decidable 𝕒 → Decidable (𝕒 → Empty)
                  ¬ yes a = no λ f → f a
                  ¬ no a = yes a
                  
                  _∧_ : ∀ {𝕒 : Set aℓ} {𝕓 : Set bℓ} (a? : Decidable 𝕒) (b? : Decidable 𝕓) → Decidable (Both 𝕒 𝕓)
                  yes a ∧ yes b = yes (Both.both a b)
                  no f ∧ _ = no λ both → f (Both.first both)
                  _ ∧ no f = no λ both → f (Both.second both)
                  
                  _∨_ : ∀ {𝕒 : Set aℓ} {𝕓 : Set bℓ} (a? : Decidable 𝕒) (b? : Decidable 𝕓) → Decidable (These 𝕒 𝕓)
                  no af ∨ no bf = no {!!}
                  yes a ∨ yes b = yes (These.these a b)
                  yes a ∨ no _ = yes (These.this a)
                  no _ ∨ yes b = yes (These.that b)
                  
                  _⇢_ : ∀ {𝕒 : Set aℓ} {𝕓 : Set bℓ} (a? : Decidable 𝕒) (b? : Decidable 𝕓) → Decidable (𝕒 → 𝕓)
                  _ ⇢ yes b = yes λ _ → b
                  no af ⇢ _ = yes λ a → Empty.eliminate (af a)
                  yes a ⇢ no bf = no λ f → bf (f a)
                  
                  True False : Decidable 𝕒 → Set
                  
                  True (yes _) = Unit
                  True (no _) = Empty
                  False a? = True (¬ a?)
            
            style = record { Style }
            
            if′_then_else_ : Decidable 𝕒 → 𝕓 → 𝕓 → 𝕓
            if′ yes _ then a else _ = a
            if′ no _ then _ else a = a
            
            if_then_else_ :
                  ∀ (a : Decidable 𝕒)
                  → (∀ ⦃ witness : 𝕒 ⦄ → 𝕓)
                  → (∀ ⦃ witness : 𝕒 → Empty ⦄ → 𝕓)
                  → 𝕓
            if yes w then a else _ = a ⦃ witness = w ⦄
            if no w then _ else a = a ⦃ witness = w ⦄
            
            to‐witness : ∀ {a? : Decidable 𝕒} → Style.True a? → 𝕒
            to‐false‐witness : ∀ {a? : Decidable 𝕒} → Style.False a? → 𝕒 → Empty
            
            from‐witness : ∀ {a? : Decidable 𝕒} → 𝕒 → Style.True a?
            from‐false‐witness : ∀ {a? : Decidable 𝕒} → (𝕒 → Empty) → Style.False a?
            
            to‐witness {a? = yes a} _ = a
            to‐false‐witness {a? = no f} _ = f
            
            from‐witness {a? = yes a} _ = _
            from‐witness {a? = no f} w = f w
            from‐false‐witness {a? = no f} _ = _
            from‐false‐witness {a? = yes a} w = w a
