{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Standard.Data.Unit where

open import Light.Library.Data.Unit using (Library ; Dependencies)

instance dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record { Implementation }
      where
      module Implementation where
            open import Data.Unit using () renaming (⊤ to Unit ; tt to unit) public
