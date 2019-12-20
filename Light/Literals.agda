{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Literals where

module Definition where
      module Natural where open import Light.Literals.Definition.Natural public
      module Negative where open import Light.Literals.Definition.Negative public

module Natural where open import Light.Literals.Natural public
module Level where open import Light.Literals.Level public
module Integer where open import Light.Literals.Integer public
