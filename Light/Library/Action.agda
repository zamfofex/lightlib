{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Library.Action where

open import Light.Level using (Level ; Setω)
open import Light.Library.Data.Unit as Unit using (Unit)
open import Light.Library.Data.Natural as Natural using (ℕ)
open import Light.Variable.Sets
open import Light.Variable.Levels
open import Light.Package using (Package)

record Dependencies : Setω where
      field ⦃ unit‐package ⦄ : Package record { Unit }
      field ⦃ natural‐package ⦄ : Package record { Natural }

record Library (dependencies : Dependencies) : Setω where
      field
            main‐ℓ : Level
            Action : Set aℓ → Set aℓ
            pure : 𝕒 → Action 𝕒
            _>>=_ : Action 𝕒 → (𝕒 → Action 𝕓) → Action 𝕓
            _>>_ : Action 𝕒 → Action 𝕓 → Action 𝕓
            log : 𝕒 → Action Unit
            Main : Set main‐ℓ
            run : Action Unit → Main
            prompt : Action ℕ
            alert : 𝕒 → Action Unit
open Library ⦃ ... ⦄ public
