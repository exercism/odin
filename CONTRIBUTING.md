# How to Contribute to the Odin Track

If you are interested, there are several way to contribute to the Odin track.

- Fill in a bug report (and possibly contribute a fix)
- Provide suggestions for improvements
- Improve the documentation for an exercise or a concept
- Contribute a new exercise

In any of these cases, you need to be aware of how to communicate your intent or request and how the Odin track maintainers operate to know what to expect.

The Odin track maintainers are doing their best to be responsive but we do have a life and may not live in your time zone. It may take a couple of days before you get some response.

## Bug Report

You are working an Odin exercise on the track and think you found a problem, or you are a contributor to the track and have a problem with one of the tools provided with the track.

1. Check your version of Odin vs. our version of Odin. The version we use is listed on the [README][odin-version].
2. Check the [Issues Page][github-odin-issues]. If the issue already exist you can read the status or post additional information there.
3. If your problem hasn't been reported, you can post a question on the [Exercism Support Forum][exercism-support-forum]. You get a good chance that somebody will respond.
4. Based on the response you got on the forum, you may decide to post an [issue][github-odin-issues]. If you do, follow the format below.

### Posting a Bug Report

Use a clear and descriptive title. If your problem is with a particular exercise or a particular tool, list its name.

Provide a detailed descriptions of your problem:

- What happened?
- What were you expecting?
- What are the steps to reproduce the problem? (This is really important, if we can't reproduce your problem, we can't fix it.)
- What environment are you running
  - Exercism environment (UI vs. CLI)
  - If you are running locally; OS, CPU, Odin compiler version, shell, any other tool involved in the problem
  - Any Log extract showing the problem

## Suggestions for Improvement

Improvements can address both the exercise tests and documentation and the track tooling and documentation.

The practice exercises in the Odin track come from the standard set used by Exercism across multiple tracks.
They have been subject to lots of scrutiny but there is always room for improvement.

If you have a general issue with the exercise, the best place is to take it with the Exercism community, through the [Exercism Support Forum][exercism-support-forum] first and then possibly by opening an issue against the [Exercism Problem Specification Repo][github-exercism-problem-specification-issues].

If you have a problem with Odin specific implementation, for example because Odin language features make the exercise too easy or too hard or would require extra information and you want to suggest improvements, then:

1. Check the [Issues Page][github-odin-issues]. If a similar suggestion already exist you can read its status and contribute ideas.
2. If your suggestion is new, you can then post on the [Exercism Support Forum][exercism-support-forum].
3. If, after discussion on the forum, you think your suggestion would help, post an [issue][github-odin-issues], following the format below.

### Posting a Suggestion for Improvement

Use a clear and descriptive title. List the exercise, concept, or tool to which your suggestion apply.

Provide a detailed descriptions of your suggestion:

- What problem are you trying to address?
- What is your proposed solution?
- Why would this be beneficial?
- Any reference to existing resources that could be used in implementing the suggestion.

### Improve the Documentation for an Exercise or a Concept

There are two kinds of exercises: practice exercises and concept exercises.
The practice exercises are standard across multiple Exercism track and their documentation (the instructions and the (optional) introduction) are standardized.
What we can do, as part of the Odin track, is add supplemental documentation (both to the instructions and the introduction), as well as add some approach discussion and some articles on techniques specific to solving an exercise. You can read about what can be provided in the [Exercism doc for Practice Exercises][exercism-practice-exercise-doc].
Concept exercises are specific to the Odin track and the instructions and introduction material are specific to the track and also subject to improvement.

Finally the list of concepts associated with the Odin track includes a more substantial introduction and a set of references and are discussed in the [Exercism doc for Concepts][exercism-concept-doc]. In addition the set of concepts for the track forms a concept map for which you may have suggestions. The [Exercism doc for the Concept Map][exercism-concept-map-doc] provides more detail.

The golden rule, **before you start any work on documentation** is to coordinate with the track maintainers. We would not want your work to be wasted because it duplicate what we are already working on or because we made the decision to disagree with your proposal. 

1. Check the [Issues Page][github-odin-issues]. If there exist an issue suggesting work on the same set of documentation you are targeting, jump in.
2. If your suggestion is new, you can then post on the [Exercism Support Forum][exercism-support-forum].
3. If, after discussion on the forum, you still think your idea wold improve the Odin track, go ahead and post an [issue][github-odin-issues], following the format below.

### Posting a Suggestion for Documentation

Use a clear and descriptive title. List the exercise or concept to which the documentation apply.

Provide a detailed descriptions of your proposed changes

- What documentation problem are you addressing?
- What documents or concepts do yo propose to change?
- Why would this be beneficial?
- Any reference to existing sources you plan to use.


### Contributing an Exercise

You would like to help with the track and build some exercises. This mostly applies to the practice exercises since each concept has a single associated exercise that we developed to demonstrate the concept.

We maintain a practice exercise wishlist [here][odin-exercise-wishlist]. If you are interested in an exercise, you can check its instructions and test specifications [here][github-exercism-problem-specifications-list].

**Before you get started**, you need to:

- Have some familiarity with the [Odin language][odin-language-overview]
- Read [How to Contribute an Exercise][odin-contributing-an-exercise]
- Read [The Odin Developer FAQ][odin-developer-faq]
- Work a couple of the [Odin Track][exercism-odin-track] exercises (both from the Exercism UI and CLI) to get a feel of what the student has to work with
- Check the Odin version of the [Allergies][exercism-odin-allergies] exercise to see what a complete exercise looks like
- Post a comment on the [Odin Exercise Wishlist][odin-exercise-wishlist] asking if you can claim that exercise.
- Do not start work until you get an answer (somebody else may have claimed it in the meantime, we try to keep the 'claimed' version of that issue up-to-date but everything we do is asynchronous)
- Once you start, if you have any question or need help, post on the same wishlist.
- This is explained in the [How to Contribute an Exercise][odin-contributing-an-exercise] but is worth repeating, **only submit one exercise** per Pull Request. Large PR with multiple exercises have proven unmanageable and we will reject any (for both your and our benefit).

## We Are All volunteers

The Odin track maintainers do their best to build and improve the track and any help is welcome. We do try to be responsive and check Issues and Pull Requests daily between us but life happens and it may be a couple of days before you get a response. But we will get back to you. Thank you for reading!

[github-odin-issues]: https://github.com/exercism/odin/issues
[exercism-support-forum]: https://forum.exercism.org/c/support/8
[odin-version]: README.md#odin-version
[github-exercism-problem-specification-issues]: https://github.com/exercism/problem-specifications/issues
[github-exercism-problem-specifications-list]: https://github.com/exercism/problem-specifications/tree/main/exercises
[exercism-practice-exercise-doc]: https://exercism.org/docs/building/tracks/practice-exercises
[exercism-concept-doc]: https://exercism.org/docs/building/tracks/concepts
[exercism-concept-map-doc]: https://exercism.org/docs/building/tracks/concept-map
[odin-exercise-wishlist]: https://github.com/exercism/odin/issues/53
[odin-contributing-an-exercise]: dev/docs/how_to_contribute_an_exercise.md
[odin-developer-faq]: dev/docs/FAQ.md
[odin-language-overview]: https://odin-lang.org/docs/overview/
[exercism-odin-track]: https://exercism.org/tracks/odin
[exercism-odin-allergies]: https://github.com/exercism/odin/tree/main/exercises/practice/allergies