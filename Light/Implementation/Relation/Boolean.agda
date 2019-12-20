{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Relation.Boolean where

open import Light.Library.Data.Boolean as Boolean using (Boolean)
open import Light.Package using (Package)
open import Light.Level using (_⊔_ ; Lifted)
open import Light.Variable.Levels
open import Light.Variable.Sets
open import Light.Library.Data.Unit as Unit using (Unit ; unit)
open import Light.Library.Data.Empty as Empty using (Empty)
open import Light.Library.Relation using (Style)
open import Light.Implementation.Data.Boolean
open import Light.Implementation.Data.Unit
open import Light.Implementation.Data.Empty

instance relation : Style record { Proposition = λ _ → Boolean ; Index = Unit }
relation = record { Implementation }
      where
      module Implementation where
            open Boolean using (true ; false ; ¬_ ; _∧_ ; _∨_ ; _⇢_) public
            
            True = Boolean.if_then Unit else Empty
            False = Boolean.if_then Empty else Unit
