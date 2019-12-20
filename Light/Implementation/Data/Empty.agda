{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Data.Empty where

open import Light.Library.Data.Empty using (Library ; Dependencies)
open import Light.Level using (0ℓ)
open import Light.Variable.Sets

instance dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record { Implementation }
      where
      module Implementation where
            data Empty : Set where
            
            eliminate : Empty → 𝕒
            eliminate ()
