module Tongues.Classes.Row.List
  ( class RowEqList
  , class RowListStep
  , module Reexports
  )
  where

import Type.Row (kind RowList, Cons, Nil) as Reexports
import Tongues.Classes.Row as Row
import Data.Symbol (class IsSymbol)
import Type.Row (class ListToRow, class RowToList)

class
  ( ListToRow    list row
  , RowToList    row list
  ) <= RowEqList row list
  | row -> list, list -> row
instance rowEqList ::
  ( ListToRow    list row
  , RowToList    row list
  ) => RowEqList row list

class
  ( IsSymbol       s
  , Row.ConsUnique s t r   r'
  , Row.ConsUnion  s t r n r'
  , RowEqList          r      rl
  , RowEqList              r'    rl'
  ) <= RowListStep s t r n r' rl rl'
  |             -> s t r n r' rl rl'
instance rowListStep ::
  ( IsSymbol       s
  , Row.ConsUnique s t r   r'
  , Row.ConsUnion  s t r n r'
  , RowEqList          r      rl
  , RowEqList              r'    rl'
  ) => RowListStep s t r n r' rl rl'
