# Instructions

In this exercise, you're going to write some code to help you cook some lasagna.
You have four tasks related to the time require to cook the lasagna.

## 1. Define the expected time spent in the oven

Define the `OVEN_TIME` constant that represents how long (in minutes) the lasagna should cook in the oven.
Checkin in your cookbook, you find this should be 40 minutes.

## 2. Calculate the remaining oven time.

Define the procedure `remaining_oven_time` that computes how many minutes are left before the lasagna are cooked given that they have already be in the oven for `actual_minutes_in_oven` minutes.

```odin
remaining_oven_time(30)
// Returns 10
```

## 3. Calculate the preparation time in minutes

Given that the preparation time is proportional to the number of layers in your lasagna and that each layer takes two minutes to prepare, implement the procedure `preparation_time` that computes the total time it took you to prepare the lasagna.


```odin
preparation_time(2)
// Returns 4
```

## 4. Calculate the total working time in minutes

To know the total time it took from when you started to now, define the procedure `elapsed_time` which, given the `number_of_layers` in your lasagna and the `actual_minutes_in_oven` computes how many minutes you have spent working so far.

```odin
elapsed_time(3, 20)
// Return 26
```


