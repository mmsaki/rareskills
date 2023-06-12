# Types

1. Solidity is statically types e.g `uint256 value`, you need to declare types
1. [This is the order of precedence of operations](https://docs.soliditylang.org/en/latest/types.html#order)
1. The concept of **undefined** of **null** DOES NOT EXIST in solidity
1. Newly declared variables always have a **default value** dependent on its type
1. To handle unexpected values, you shout use the `revert()` function, to revert the whole transaction, or return a tuple with a secind bool value denoting success `(value, bool) = `
1. Value Types:
   1. Booleans: True of False
   1. Opearators:
      1. `!` - logical negation
      1. `&&` - logical conjunction, and
      1. `||` - logical disjuntion or
      1. `==` - equality
      1. `!=` - inequality
         > **Note**: The operators `||` and `&&` apply the common short-circuitung rules. This means that expressiong `f(x) || g(y)`, if `f(x)` evaluates to true, g(y)will not be evaluated even if it may have side-effects.
   1. Integers
      1. `int` or `uint` signed and unsigned integers of various sizes, `uint8` to `uint256` in steps of `8`
      1. Operators:
         1. Comparisons: `<=`, `<`, `==`, `!=`, `>=`, `>` - evaluate to `bool`
         1. Bit operators: `&`, `|`, `^` (exclusive or - xor), `~` (bitwise negation)
         1. Shift operators: `<<`, `>>`
            > The righy operand must be of uinsigned type, trying to shift by signed type will produce a compilation error. `x << y` $\equiv$ `x * 2**y`, `x >> y` $\equiv$ `x / 2**y`,
            > **Warning**: Overflow checks are never performed for shift operations as they are done for arithmetic operations. Instead the result is truncated.
         1. Arithmetic operators: `+`, `-`, `-` unary (only for signed integers), `*`, `/`, `%`, `**`
         1. for integer X, `type(X).min` and `type(X).max` for minimum and maximum values presentable by the type
