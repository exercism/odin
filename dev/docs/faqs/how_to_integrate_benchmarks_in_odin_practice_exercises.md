# How to Integrate Benchmarks in Odin Practice Exercises?

If you are developing an exercise and you want to add benchmark code, you **must** follow the guidance below.

Benchmark are really intended for students running the exercise on their local machine, not through the Exercism UI, therefore the test attribute for the benchmark code **should be commented out** when you submit the exercise Pull Request.
In addition, you should place a header in the test file explaining that the benchmarks are optional and the `@(test)` attribute must be uncommented for the benchmark to be executed.

```odin
// Optional Benchmarking Code
// If you are using Exercism CLI Interface and want to test
// the performance of your solution, un-comment the following
// test attribute.

// @(test)
benchmark_pascals_triangle :: proc(t: ^testing.T) {
    ...
}
```

The Odin `core:time` package provides a `benchmark()` method that can provide timing information on the exercise procedures. You can see how to set it up in the [Pascal Triangle Tests][odin-pascal-triangle-tests].

The Test Runner has strict limits (CPU and time) and is not a good environment for benchmarking.
Adding un-commented benchmark code to the tests may cause the Test Runner to time out (if you are running through the Exercism UI) frustrating students who have a correct solution.

[odin-pascal-triangle-tests]: https://github.com/exercism/odin/blob/main/exercises/practice/pascals-triangle/pascals_triangle_test.odin
