{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Standard.Data.Empty where

open import Light.Library.Data.Empty using (Library ; Dependencies)

instance dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record { Implementation }
      where
      module Implementation where
            open import Data.Empty using () renaming (⊥ to Empty ; ⊥-elim to eliminate) public
