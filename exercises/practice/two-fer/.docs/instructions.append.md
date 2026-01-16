# Instructions append

## Odin-specific instructions

This exercise requires the use of a default parameter.
In Odin, a default parameter is defined by assigning a value to the parameter in the procedure signature.

```odin
greeting :: proc(name : string = "John Doe") {
	...
}
```

Because Odin supports type inference based on the initial value, you can omit the type when setting default values. This is similar to how you define variables.

```odin
greeting :: proc(name := "John Doe") {
	...
}
```
