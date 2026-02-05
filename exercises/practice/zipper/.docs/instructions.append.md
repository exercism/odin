# Instructions append

## Odin-specific instructions

### Zipper on Binary Trees

The instructions above discuss the zipper using a rose tree (multiple children per node) but the zipper concept can be applied to any type of tree and even to list.
For this exercise, we will be using a binary tree (each node has two children) so we can focus on the zipper operations instead of focusing on managing a dynamic number of children.

The operations listed in the instructions, have been updated to match binary trees:

| Operation       | Description                                                                |
| --------------- | -------------------------------------------------------------------------- |
|`zip_from_tree`  | Get a zipper out of a tree, the focus is on the root node.                 |
|`zip_to_tree`    | Get the tree out of the zipper.                                            |
| `zip_value`     | Get the value of the focus node.                                           |
| `zip_left`      | Move the focus to the left child of the focus node, returns a new zipper.  |
| `zip_right`     | Move the focus to the right child of the focus node, returns a new zipper. |
| `zip_up`        | Move the focus to the parent of the focus node, returns a new zipper.      |
| `zip_set_value` | Set the value of the focus node, returns a new zipper.                     |
| `zip_set_left`  | Set the left subtree of the focus node, returns a new zipper.              |
| `zip_set_right` | Set the right subtree of the focus node, returns a new zipper.             |

### Memory Management

In Odin you have to manually manage memory.
To simplify the exercise and focus on the Zipper operations, the memory allocated to the tree nodes and the trails is automatically managed for you via an arena allocator.
You only need to allocate memory as needed with `new(Node)` and `new(Step)`; when we are done operating on the tree, the test will automatically call `free_all()` on the arena.
This is the idiomatic way to deal with memory allocations in Odin for any periodic process (like a game loop or a set of requests/replies).

If you want to learn more on allocators in Odin, specifically arena allocators, you may find the following documents interesting: [The Allocator chapter in the Odin Overview][allocators-overview], [Understand the Temporary Allocator; Understand arenas by Karl Zylinski][allocators-zylinksi], and [Linear/Arena Allocators by gingerBill][allocators-gingerbill].

[allocators-gingerbill]: https://www.gingerbill.org/article/2019/02/08/memory-allocation-strategies-002/
[allocators-zylinksi]: https://zylinski.se/posts/temporary-allocator-your-first-arena/
[allocators-overview]: https://odin-lang.org/docs/overview/#allocators
