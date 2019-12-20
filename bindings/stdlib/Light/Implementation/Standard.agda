{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Standard where

module Data where
      module Empty where open import Light.Implementation.Standard.Data.Empty public
      module Unit where open import Light.Implementation.Standard.Data.Unit public
      module These where open import Light.Implementation.Standard.Data.These public
      module Product where open import Light.Implementation.Standard.Data.Product public

module Relation where
      module Decidable where open import Light.Implementation.Standard.Relation.Decidable public
      module Sets where open import Light.Implementation.Standard.Relation.Sets public
