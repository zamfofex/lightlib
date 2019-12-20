{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation where

module Data where
      module Empty where open import Light.Implementation.Data.Empty public
      module Either where open import Light.Implementation.Data.Either public
      module Natural where open import Light.Implementation.Data.Natural public
      module Unit where open import Light.Implementation.Data.Unit public
      module Integer where open import Light.Implementation.Data.Integer public
      module Boolean where open import Light.Implementation.Data.Boolean public
      module Product where open import Light.Implementation.Data.Product public
      module These where open import Light.Implementation.Data.These public

module Relation where
      module Sets where open import Light.Implementation.Relation.Sets public
      module Boolean where open import Light.Implementation.Relation.Boolean public
      module Binary where
            module Equality where
                  module Propositional where
                        open import Light.Implementation.Relation.Binary.Equality.Propositional public
                        module Decidable where open import Light.Implementation.Relation.Binary.Equality.Propositional.Decidable public
      module Decidable where open import Light.Implementation.Relation.Decidable public

module Action where open import Light.Implementation.Action public
