# Introductions append

In Forth functions are called `words`, they operate on a data stack.
Each word takes its parameter(s) from the stack and return its result(s) on the stack.

The Forth documentation always contains the state of the data stack before the word is executed and after the word is executed in the following manner `( p1 p2 ... pN --- r1 r2 ... rN )`.
The values `p1` to `pN` represent the word parameters on the stack before the call (the stack can have additional data further up the stack, not represented here) and the values `r1` to `rN` represent the word return values on the stack after the call.
The separator `---` distinguish the stack state before and after the word execution.

The words to be implemented are defined as:

- ToS stands for Top of Stack
- The Top of the Stack is represented as the rightmost value

| word   | stack state             | description                          |
| ------ | ----------------------- | ------------------------------------ |
| `+`    | `( a b --- sum )`       | `sum = a + b`                        |
| `-`    | `( a b --- diff )`      | `diff = a - b`                       |
| `*`    | `( a b --- prod )`      | `prod = a * b`                       |
| `/`    | `( a b --- quot )`      | `quot = a / b`                       |
| `dup`  | `( a --- a a )`         | duplicate the value on the ToS       |
| `drop` | `( a --- )`             | drop the value on the ToS            |
| `swap` | `( a b --- b a )`       | swap the two values on the ToS       |
|`over`  | `( a b c --- a b c b )` | copy the 2nd value        to the ToS |

If you want to play with an online forth interpreter or learn more about the words to be implemented try [Easy Forth][easy-forth]
(specifically the Adding Some Numbers, Defining Words, and Stack Manipulation section).

[easy-forth]: https://skilldrick.github.io/easyforth/
