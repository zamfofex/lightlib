{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Package where

open import Light.Level using (Setω)

record Meta : Setω where
      field Dependencies : Setω
      field Library : Dependencies → Setω

record Package (meta : Meta) : Setω where
      instance constructor package
      open Meta meta
      field ⦃ dependencies ⦄ : Dependencies
      field ⦃ library ⦄ : Library dependencies
open Package ⦃ ... ⦄ public
