{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Relation.Binary where

open import Light.Level using (Setω ; Level)
open import Light.Variable.Levels
open import Light.Variable.Sets
open import Light.Library.Relation using (Base ; Index ; Proposition ; True ; _⇢_)

module _ ⦃ base : Base ⦄ where
      record Binary (𝕒 : Set aℓ) (𝕓 : Set bℓ) : Setω where
            field if : 𝕒 → 𝕓 → Index
            field are : ∀ a b → Proposition (if a b)
      
      SelfBinary : Set aℓ → Setω
      SelfBinary 𝕒 = Binary 𝕒 𝕒
      
      open Binary using (are)
      
      private variable a : 𝕒
      private variable b : 𝕓
      private variable c : 𝕔
      
      record Transitive
            (a‐b‐valid : Binary 𝕒 𝕓)
            (b‐c‐valid : Binary 𝕓 𝕔)
            (a‐c‐valid : Binary 𝕒 𝕔)
            : Setω where
            
            field transitivity : True (are a‐b‐valid a b ⇢ (are b‐c‐valid b c ⇢ are a‐c‐valid a c))
      
      record Symmetric
            (a‐b‐valid : Binary 𝕒 𝕓)
            (b‐a‐valid : Binary 𝕓 𝕒)
            : Setω where
            
            field symmetry : True (are a‐b‐valid a b ⇢ are b‐a‐valid b a)
      
      record Reflexive (valid : SelfBinary 𝕒) : Setω where
            field reflexivity : True (are valid a a)
      
      SelfTransitive : ∀ (valid : SelfBinary 𝕒) → Setω
      SelfTransitive valid = Transitive valid valid valid
      
      SelfSymmetric : ∀ (valid : SelfBinary 𝕒) → Setω
      SelfSymmetric valid = Symmetric valid valid
      
      record Preserved
            (f : 𝕒 → 𝕓) (g : 𝕔 → 𝕕)
            (a‐c‐valid : Binary 𝕒 𝕔)
            (b‐d‐valid : Binary 𝕓 𝕕)
            : Setω where
            
            field preservation : True (are a‐c‐valid a c ⇢ are b‐d‐valid (f a) (g c))
            congruence = preservation
      
      CongruentFor :
            (𝕒 → 𝕓)
            → SelfBinary 𝕒
            → SelfBinary 𝕓
            → Setω
      CongruentFor f = Preserved f f
      
      SelfCongruentFor :
            (𝕒 → 𝕒)
            → SelfBinary 𝕒
            → Setω
      SelfCongruentFor f 𝕒 = CongruentFor f 𝕒 𝕒
      
      record Bijective
            (f : 𝕒 → 𝕓) (g : 𝕔 → 𝕕)
            (b‐d‐valid : Binary 𝕓 𝕕)
            (a‐c‐valid : Binary 𝕒 𝕔)
            : Setω where
            
            field bijectivity : True (are b‐d‐valid (f a) (g c) ⇢ are a‐c‐valid a c)
            injectivity = bijectivity
      
      Injective :
            (𝕒 → 𝕓)
            → SelfBinary 𝕓
            → SelfBinary 𝕒
            → Setω
      Injective f = Bijective f f
      
      SelfInjective :
            (𝕒 → 𝕒)
            → SelfBinary 𝕒
            → Setω
      SelfInjective f 𝕒 = Injective f 𝕒 𝕒

open Transitive ⦃ ... ⦄ public
open Symmetric ⦃ ... ⦄ public
open Reflexive ⦃ ... ⦄ public
open Preserved ⦃ ... ⦄ public
open Bijective ⦃ ... ⦄ public
