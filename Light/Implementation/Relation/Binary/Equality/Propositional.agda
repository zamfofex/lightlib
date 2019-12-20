{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Relation.Binary.Equality.Propositional where

open import Agda.Builtin.Equality using (_≡_ ; refl)
open import Light.Library.Relation.Binary
      using (SelfSymmetric ; SelfTransitive ; Reflexive ; Binary ; SelfBinary ; Symmetric ; Transitive ; CongruentFor ; Preserved)
open import Light.Implementation.Relation.Sets using (base) public
open import Light.Library.Relation.Binary.Equality using (SelfEquality ; wrap)
open import Light.Variable.Sets
open import Light.Variable.Levels

open Reflexive
open Symmetric
open Transitive
open Preserved

module _ {𝕒 : Set aℓ} where
      instance relation : SelfBinary 𝕒
      relation = record { are = λ a b → a ≡ b }
      
      instance reflexive : Reflexive relation
      reflexive .reflexivity = refl
      
      instance symmetric : SelfSymmetric relation
      symmetric .symmetry refl = refl
      
      instance transitive : SelfTransitive relation
      transitive .transitivity refl refl = refl
      
      instance equals : SelfEquality 𝕒
      equals = wrap relation

instance congruent : ∀ {f : 𝕒 → 𝕓} → CongruentFor f relation relation
congruent .preservation refl = refl
