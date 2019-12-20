{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}
{-# OPTIONS --allow-unsolved-metas #-}

module Light.Implementation.Relation.Binary.Equality.Propositional.Decidable where

import Light.Implementation.Relation.Binary.Equality.Propositional as Propositional
open import Light.Library.Relation.Decidable using (Decidable ; yes ; no ; if_then_else_ ; from‐witness)
open import Light.Variable.Sets
open import Light.Library.Relation.Binary.Equality using (_≈_ ; SelfEquality ; wrap)
open import Light.Library.Relation.Binary
      using (SelfSymmetric ; SelfTransitive ; Reflexive ; Binary ; SelfBinary ; Symmetric ; Transitive ; CongruentFor ; Preserved ; reflexivity ; transitivity ; symmetry ; congruence)
import Light.Implementation.Relation.Decidable
open import Light.Variable.Sets
open import Light.Variable.Levels
open import Light.Library.Relation using (_∧_ ; _⇢_)
open import Light.Library.Data.Product using (first ; second ; both)
import Light.Implementation.Data.Product

module Base {𝕒 : Set aℓ} where
      instance relation : SelfBinary 𝕒
      relation = record { are = λ a b → Decidable (a ≈ b) }
      
      instance reflexive : Reflexive relation
      reflexive .Reflexive.reflexivity = {!!}
      
      instance symmetric : SelfSymmetric relation
      symmetric .Symmetric.symmetry a‐≈?‐b =
            if a‐≈?‐b
            then (λ ⦃ b‐≈‐a ⦄ → yes (symmetry b‐≈‐a))
            else (λ ⦃ f ⦄ → no λ b‐≈‐a → f (symmetry b‐≈‐a))

      instance transitive : SelfTransitive relation
      transitive .Transitive.transitivity a‐≈?‐b b‐≈?‐c =
            if a‐≈?‐b ∧ b‐≈?‐c
            then (λ ⦃ a‐≈‐c ⦄ → yes (transitivity (first a‐≈‐c) (second a‐≈‐c)))
            else (λ ⦃ f ⦄ → no λ a‐≈‐c → f (both {!!} {!!}))

      instance equals : SelfEquality 𝕒
      equals = wrap relation

instance base‐congruent : ∀ {f : 𝕒 → 𝕓} → CongruentFor f Base.relation Base.relation
base‐congruent .Preserved.preservation a‐≈?‐c =
      if a‐≈?‐c
      then (λ ⦃ a‐≈‐c ⦄ → yes (congruence a‐≈‐c))
      else λ ⦃ f ⦄ → no λ fa‐≈‐fc → f {!!}

module Main (_≈?_ : ∀ (a b : 𝕒) → Decidable (_≈_ ⦃ r = Propositional.equals ⦄ a b)) where
      instance relation : SelfBinary 𝕒
      relation = record { are = λ a b → a ≈? b }
      
      open import Agda.Builtin.Equality using (_≡_)
      
      instance reflexive : Reflexive relation
      reflexive .Reflexive.reflexivity {a = a} = from‐witness {a? = a ≈? a} ⦃ witness = reflexivity ⦄
      
      instance symmetric : SelfSymmetric relation
      symmetric .Symmetric.symmetry {a = a} {b = b} = from‐witness {a? = (a ≈? b) ⇢ (b ≈? a)} ⦃ witness = symmetry ⦄
      
      instance transitive : SelfTransitive relation
      transitive .Transitive.transitivity {a = a} {b = b} {c = c} = from‐witness {a? = (a ≈? b) ⇢ ((b ≈? c) ⇢ (a ≈? c))} ⦃ witness = transitivity ⦄

module _ (_≈a?_ : ∀ (a b : 𝕒) → Decidable (_≈_ ⦃ r = Propositional.equals ⦄ a b)) (_≈b?_ : ∀ (a b : 𝕓) → Decidable (_≈_ ⦃ r = Propositional.equals ⦄ a b)) where
      private module A = Main _≈a?_
      private module B = Main _≈b?_
      
      instance congruent : ∀ {f : 𝕒 → 𝕓} → CongruentFor f A.relation B.relation
      congruent {f = f} .Preserved.preservation {a = a} {c = c} = from‐witness {a? = (a ≈a? c) ⇢ (f a ≈b? f c)} ⦃ witness = congruence ⦄
