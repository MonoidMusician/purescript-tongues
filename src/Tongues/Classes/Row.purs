module Tongues.Classes.Row
  ( class Cons, class With, class Has
  , class Lacks, class ConsUnique
  , class Singleton, class ConsUnion
  , module ReexportUnion, class SubRow
  )
  where

import Type.Row

import Prim (Union) as ReexportUnion
import Type.Equality (class TypeEquals)

class
  ( RowCons label typ removed added
  ) <= Cons label typ removed added
  |      -> label typ removed added
instance cons ::
  ( RowCons label typ removed added
  ) => Cons label typ removed added

class With
  (label :: Symbol)
  (typ   ::   Type)
  (row   :: # Type)
  | -> label typ row
instance with ::
  ( Cons    label typ ignored row
  ) => With label typ         row

class Has
  (label :: Symbol)
  (row   :: # Type)
  | -> label row
instance has ::
  ( With   label ignored row
  ) => Has label         row

foreign import data EvidenceForRowLacks :: Type
class RowLacks label row <= Lacks
  (label :: Symbol)
  (row   :: # Type)
  | -> label row
instance lacks ::
  ( Cons label EvidenceForRowLacks () keyEntry
  , Union row keyEntry rowKeyEntry
  , Cons label typ ignored rowKeyEntry
  , TypeEquals EvidenceForRowLacks typ
  , RowLacks label row
  ) => Lacks label row

class
  ( Cons          label typ removed added
  , Lacks         label     removed
  ) <= ConsUnique label typ removed added
  |            -> label typ removed added
instance consUnique ::
  ( Cons          label typ removed added
  , Lacks         label     removed
  ) => ConsUnique label typ removed added

class
  ( ConsUnique   label typ () single
  ) <= Singleton label typ    single
  |           -> label typ    single
instance singleton ::
  ( RowToList                 single
           (Cons label typ Nil)
  , ConsUnique   label typ () single
  ) => Singleton label typ    single

class
  ( Cons         label typ removed        added
  , Singleton    label typ         single
  , Union                  removed single added
  ) <= ConsUnion label typ removed single added
  |           -> label typ removed single added
instance consUnion ::
  ( Cons         label typ removed        added
  , Singleton    label typ         single
  , Union                  removed single added
  ) => ConsUnion label typ removed single added

-- | Use `SubRow` when you mean it, since it does not imply `Union`!
class SubRow
  (sub :: # Type)
  (row :: # Type)
  | -> sub row
instance subRow ::
  ( Union sub exists row
  ) => SubRow sub row
