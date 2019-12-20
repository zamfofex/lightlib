{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library where

module Literals where open import Light.Literals public

module Data where
      module Empty where open import Light.Library.Data.Empty public
      module Either where open import Light.Library.Data.Either public
      module Natural where open import Light.Library.Data.Natural public
      module Unit where open import Light.Library.Data.Unit public
      module Integer where open import Light.Library.Data.Integer public
      module Boolean where open import Light.Library.Data.Boolean public
      module Both where open import Light.Library.Data.Both public
      module Product where open import Light.Library.Data.Product public
      module These where open import Light.Library.Data.These public

module Relation where
      module Binary where
            open import Light.Library.Relation.Binary public
            module Equality where
                  open import Light.Library.Relation.Binary.Equality public
                  module Decidable where open import Light.Library.Relation.Binary.Equality.Decidable public
            module Decidable where open import Light.Library.Relation.Binary.Decidable public
      open import Light.Library.Relation public
      module Decidable where open import Light.Library.Relation.Decidable public

module Action where open import Light.Library.Action public

module Arithmetic where open import Light.Library.Arithmetic public
module Level where open import Light.Level public
module Subtyping where open import Light.Subtyping public

module Variable where
      module Levels where open import Light.Variable.Levels public
      module Sets where open import Light.Variable.Sets public
      module Other {ℓ} (𝕒 : Set ℓ) where open import Light.Variable.Other 𝕒 public

module Package where open import Light.Package public
open Package using (Package) hiding (module Package) public

-- module Indexed where open import Light.Indexed
