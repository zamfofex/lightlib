{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Data.Unit where

open import Light.Library.Data.Unit using (Library ; Dependencies)

instance dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record { Implementation }
      where
      module Implementation where
            record Unit : Set where constructor unit
