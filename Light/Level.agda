{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Level where

open import Agda.Primitive using (Level ; _⊔_ ; Setω) renaming (lzero to 0ℓ ; lsuc to ++_) public

record Lifted ℓ {aℓ} (𝕒 : Set aℓ) : Set (ℓ ⊔ aℓ) where
      constructor lift
      field lower : 𝕒
