{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

module Light.Implementation.Action where

open import Light.Library.Action using (Library ; Dependencies)
open import Light.Level using (++_ ; 0ℓ)
open import Light.Library.Data.Unit using (Unit)
open import Light.Library.Data.Natural using (ℕ)
open import Light.Variable.Sets
open import Light.Variable.Levels
import Light.Package
import Light.Implementation.Data.Natural
import Light.Implementation.Data.Unit

instance dependencies : Dependencies
dependencies = record {}

instance library : Library dependencies
library = record { Implementation }
      where
      module Implementation where
            postulate Main : Set
            private
                  postulate
                        pure′ : 𝕒 → Main
                        bind′ : Main → (𝕒 → Main) → Main
                        follow : Main → Main → Main
            
            {-# COMPILE JS pure′ = () => () => () => a => () => a #-}
            {-# COMPILE JS bind′ = () => () => () => m => f => f(m()) #-}
            {-# COMPILE JS follow = () => () => m => m2 => () => (m(), m2()) #-}
            
            {-# NO_UNIVERSE_CHECK #-}
            data Action (𝕒 : Set ℓ) : Set ℓ where
                  pure : 𝕒 → Action 𝕒
                  _>>=_ : Action 𝕓 → (𝕓 → Action 𝕒) → Action 𝕒
                  _>>_ : Action 𝕓 → Action 𝕒 → Action 𝕒
                  lift : Main → Action 𝕒
            
            run : Action 𝕒 → Main
            run (pure a) = pure′ a
            run (a >>= f) = bind′ (run a) (λ a → run (f a))
            run (a >> b) = follow (run a) (run b)
            run (lift m) = m
            
            private
                  postulate log′ alert′ : 𝕒 → Main
                  postulate prompt′ : Main
            
            log : 𝕒 → Action Unit
            log a = lift (log′ a)
            
            prompt = lift prompt′
            
            alert : 𝕒 → Action Unit
            alert a = lift (alert′ a)
            
            {-# COMPILE JS log′ = () => () => a => () => console.log(a) #-}
            {-# COMPILE JS prompt′ = () => () => BigInt(prompt()) #-}
            {-# COMPILE JS alert′ = () => () => () => a => alert(a) #-}
