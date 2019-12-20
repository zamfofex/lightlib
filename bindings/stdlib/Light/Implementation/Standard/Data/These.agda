{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Standard.Data.These where

open import Light.Library.Data.These using (Library ; Dependencies)

instance dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record { Implementation }
      where
      module Implementation where
            open import Data.These using (These ; this ; that ; these) public
