## Background
Operators are great! We love them. But sometimes you just need to apply one argument to them. That's great too.

Functions are awesome at partial application, and judicious use of `flip` and `flap` (`<@>`) makes for more fun.

For operators, we can use sections to apply either left _or_ right values. In PureScript the syntax is a slight bit more verbose, but no matter: `(a <> _)` to apply a left argument, and `(_ <> b)` to apply a right argument.

PureScript also requires that these operators all have names (useful when generating readable code): `<>` is called `append`!

The way these methods are defined is designed for using them like `append a b`, where `a` is ostensibly the thing on the left, and `b` goes on the right.

## The Problem
But then partial application happens and suddenly `append x` no longer _appends_ to a semigroup, but _prepends_ `x` to the next value passed in!

**This is ridiculous.**

## The Solution
So I created a module that rights this wrong by lefting all the rights. With the functions in this module, `append b` will really mean that `b` gets appended; the old `append` is now `prepend`, since that is what makes sense in English, when used as a section.

Thus, most functions in this module are simply flipped versions of the methods provided in Prelude, with other names corresponding to the original Prelude methods.

Some others have had prepositions added to their names to make better sense in English.

All suggestions and pull requests are welcome!

## Rule of Thumb
This is confusing, but so is English. So if you get confused, ask yourself how many arguments you are going to be giving to the function at once? This will determine which version will make the most sense:
1. Perfect, use this library!
2. Cool, just use the regular version

In order for you and grokkers of your code to be able to readily distinguish the functions, a qualified import is recommended.

Note that signatures in the source use extra parentheses to remind you that they are best used as partially applied functions!

## Examples
```purescript
import Data.Functor (map)
import Tongues.Sections (append, prepend) as Section

map (Section.append " ") ["Hello", "World"] == ["Hello ", "World "]
map (Section.prepend " ") ["Hello", "World"] == [" Hello", " World"]

mkQualified modules reference =
  Section.append reference $ foldMap (Section.append ".") modules
mkQualified ["Tongues", "Sections"] "append" == "Tongues.Sections.append"
```
