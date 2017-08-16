module Tongues.Sections where

import Data.Semigroup as Data.Semigroup
import Data.Semiring as Data.Semiring
import Data.Ring as Data.Ring
import Data.EuclideanRing as Data.EuclideanRing
import Data.Ord as Data.Ord
import Control.Semigroupoid as Control.Semigroupoid
import Data.Function as Data.Function
import Data.Functor as Data.Functor
import Data.Function (flip)

prepend :: forall a. Data.Semigroup.Semigroup a => a -> (a -> a)
prepend = Data.Semigroup.append

append :: forall a. Data.Semigroup.Semigroup a => a -> (a -> a)
append = flip prepend

addTo :: forall a. Data.Semiring.Semiring a => a -> (a -> a)
addTo = Data.Semiring.add

multiplyBy :: forall a. Data.Semiring.Semiring a => a -> (a -> a)
multiplyBy = Data.Semiring.mul

subtractFrom :: forall a. Data.Ring.Ring a => a -> (a -> a)
subtractFrom = Data.Ring.sub

minus :: forall a. Data.Ring.Ring a => a -> (a -> a)
minus = flip subtractFrom

-- divideBy 5 = (_/5)
divideBy :: forall a. Data.EuclideanRing.EuclideanRing a => a -> (a -> a)
divideBy = Data.EuclideanRing.div

-- | sgn = compareTo zero
-- | sgn one = GT
-- | sgn zero = EQ
-- | sgn (negate one) = LT
compareTo :: forall a. Data.Ord.Ord a => a -> (a -> Data.Ord.Ordering)
compareTo = flip Data.Ord.compare

composeAfter :: forall b c d a. Control.Semigroupoid.Semigroupoid a => a c d -> (a b c -> a b d)
composeAfter = Control.Semigroupoid.compose

composeBefore :: forall b c d a. Control.Semigroupoid.Semigroupoid a => a b c -> (a c d -> a b d)
composeBefore = flip composeAfter

applyTo :: forall a b. (a -> b) -> (a -> b)
applyTo = Data.Function.apply

applyValue :: forall a b. a -> ((a -> b) -> b)
applyValue = flip applyTo

mapTo :: forall f a b. Data.Functor.Functor f => b -> (f a -> f b)
mapTo = Data.Functor.voidRight
