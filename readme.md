lightlib
===

lightlib is an alternative core library for Agda. The hope is to provide the basic set of needed definitions for programming in Agda.

It is meant to be used for writing programs primarily, and as such, it makes various decisions that facilitate programming over proving.

interface vs. implementation
---

The foundational decision that drove the entirety of the creation of the library was to discern *interface* from *implementation*.

Generally, in dependently‐typed programming languages, the implementation of a definition is strongly bound to it, and changing it is a breaking change. Even when two implementations of such a construct reduce to the same values given the same concrete input, its effect can still differ given symbolic input, which is possible with dependent types at hand.

lightlib aims to allow implementations to change to accommodate for e.g. performance or convenience without breaking users’s code.

By not relying on a specific implementation, users of the library let their code be freely attachable to some arbitrary implementation for being run.

Another useful consequence of that decision is that, given a library that depends on lightlib, users of that library do not need to be attached to a specific implementation in order to use it. This gives flexibility to the users of that library: when using it, instead of being bound to a specific core library that the author might have preferred, they are free to choose from a core library that better suits their needs.

using lightlib without relying on implementation
---

In order to use lightlib’s interface, without relying on an underlying implementation, it is possible to write import the `Light.Library` module, and use the exported modules.

However, it is important to note that it is necessary to add a `Package record { Foo }` instance parameter for each module `Foo` that needs to be used.

For example:

~~~ Agda
open import Light.Library

module Example ⦃ natural‐package : Package record { Data.Natural } ⦄ where

open Data.Natural using (ℕ ; _+_ ; _∗_)

a b c d : ℕ

a = 12
b = 2
c = 27

d = (a ∗ b) + c
~~~

relying on a specific implementation
---

As elaborated, lightlib can be used without a specific implementation, however, that feature is optional. The user can rely on some specific implementation if they would like.

It is possible to use the standard library as an implementation for some basic datatypes and decidable relations. This allows lightlibbers to make use of features in other libraries, while still using lightlib.

In order to use lightlib’s own implementation, it should suffice to import the `Light` module, and then directly use the exported modules. For example:

~~~ Agda
module Example where

open import Light

open Data.Natural using (ℕ ; _+_ ; _∗_)

a b c d : ℕ

a = 12
b = 2
c = 27

d = (a ∗ b) + c
~~~

In order to use some other implementation, it is possible to import `Light.Library`, and then the other implementation’s module. (Such as `Light.Implementation.Standard` for the standard library implementation.)

using libraries that use lightlib
---

It is possible to use implementation‐agnostic modules from implementation‐specific modules, but not the converse.

It is only possible to use an implementation‐specific module from another one if the two implementations are the same.
