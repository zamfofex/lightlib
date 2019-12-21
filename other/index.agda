{-# OPTIONS --omega-in-omega --no-termination-check --overlapping-instances #-}

-- This library is licensed under 0BSD. You can read more about it at its GitHub repository: https://github.com/Zambonifofex/lightlib

module index where

-- The `Light.Libary` file exports modules referencing interface files and other miscellaneous files in the library.
import Light.Library

-- The `Light.Implementation` file exports modules referencing files that provide an implementation for the interfaces above.
import Light.Implementation

-- The `Light` file can be used conveniently to use the given implementation for their appropriate interfaces.
import Light

-- The `Light.Implementation.Standard` file provides an implementation that uses definitions from the standard library: https://github.com/agda/agda-stdlib
import Light.Implementation.Standard
