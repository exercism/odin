In this exercise you will implement a procedure which is meant to allocate the string it returns. Deallocating the string is the responsibility of the prodecure's caller.

```odin
// The procedure will be called like that:
formatted := format("Gianna", 4)
// ...
// and eventually the caller will delete the string
delete(formatted)
```
