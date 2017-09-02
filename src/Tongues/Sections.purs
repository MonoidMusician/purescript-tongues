module Tongues.Sections where

import Data.Semigroup as Data.Semigroup
import Data.Semiring as Data.Semiring
import Data.Ring as Data.Ring
import Data.EuclideanRing as Data.EuclideanRing
import Data.Ord as Data.Ord
import Control.Semigroupoid as Control.Semigroupoid
import Data.Function as Data.Function
import Data.Functor as Data.Functor
import Data.Function (flip, id)

-- | `prepend a == (a <> _)`
prepend :: forall a. Data.Semigroup.Semigroup a => a -> (a -> a)
prepend = Data.Semigroup.append

-- | `append b == (_ <> b)`
append :: forall a. Data.Semigroup.Semigroup a => a -> (a -> a)
append = flip prepend

-- | `addTo a == (a + _)`
addTo :: forall a. Data.Semiring.Semiring a => a -> (a -> a)
addTo = Data.Semiring.add

-- | FIXME: how should English for non-commutative semirings???
-- | `multiplyBy `
multiplyBy :: forall a. Data.Semiring.Semiring a => a -> (a -> a)
multiplyBy = Data.Semiring.mul

-- | `subtractFrom a == (a - _)`
subtractFrom :: forall a. Data.Ring.Ring a => a -> (a -> a)
subtractFrom = Data.Ring.sub

-- | `minus b == (_ - b)`
minus :: forall a. Data.Ring.Ring a => a -> (a -> a)
minus = flip subtractFrom

-- `divideBy b = (_/b)`
divideBy :: forall a. Data.EuclideanRing.EuclideanRing a => a -> (a -> a)
divideBy = Data.EuclideanRing.div

-- | `compareTo a == (a `compare` _)`
-- |
-- | Example:
-- | ```purescript
-- | sgn = compareTo zero
-- | sgn one = GT
-- | sgn zero = EQ
-- | sgn (negate one) = LT
-- | ```
compareTo :: forall a. Data.Ord.Ord a => a -> (a -> Data.Ord.Ordering)
compareTo = flip Data.Ord.compare

-- | `lessThan b == (_ < b) == (b > _)`
lessThan :: forall a. Data.Ord.Ord a => a -> (a -> Boolean)
lessThan = Data.Ord.greaterThan

-- | `greaterThan b == (_ > b) == (b < _)`
greaterThan :: forall a. Data.Ord.Ord a => a -> (a -> Boolean)
greaterThan = Data.Ord.lessThan

-- | `lessThanOrEq b == (_ <= b) == (b >= _)`
lessThanOrEq :: forall a. Data.Ord.Ord a => a -> (a -> Boolean)
lessThanOrEq = Data.Ord.greaterThanOrEq

-- | `greaterThanOrEq b == (_ >= b) == (b <= _)`
greaterThanOrEq :: forall a. Data.Ord.Ord a => a -> (a -> Boolean)
greaterThanOrEq = Data.Ord.lessThanOrEq

-- | `noLessThan a == \b -> if b < a then a else b == max a`
-- | Alternative names welcome.
noLessThan :: forall a. Data.Ord.Ord a => a -> (a -> a)
noLessThan = Data.Ord.max

-- | `noGreaterThan a == \b -> if b > a then a else b == min a`
noGreaterThan :: forall a. Data.Ord.Ord a => a -> (a -> a)
noGreaterThan = Data.Ord.min

-- | `composeBefore a == (a <<< _) == (_ >>> a)`
composeBefore :: forall b c d a. Control.Semigroupoid.Semigroupoid a => a b c -> (a c d -> a b d)
composeBefore = flip composeAfter

-- | `composeAfter b == (_ <<< b) == (b >>> _)`
composeAfter :: forall b c d a. Control.Semigroupoid.Semigroupoid a => a c d -> (a b c -> a b d)
composeAfter = Control.Semigroupoid.compose

-- | `applyTo x == (_ $ x) == (x # _)`
applyTo :: forall a b. a -> ((a -> b) -> b)
applyTo = flip id

-- | `mapTo x == (_ $> x) == (x <$ _) == (const x <$> _) == (_ <#> const x)`
mapTo :: forall f a b. Data.Functor.Functor f => b -> (f a -> f b)
mapTo = Data.Functor.voidRight
