---
title: Javascript to a strongly typed language..
date: 2022-01-19T09:40:48+08:00
description: What approach can one take to move an existing Javascript code base to a strongly typed language?
---

<style>
.side-by-side { display: flex; justify-content: space-evenly; align-items: center;}
.side-by-side img {flex: 1; max-width:20% }
</style>

# Less bugs wanted

There comes a time when a weakly typed Javascript project wants to adopt **strong
typing** to improve quality and avoid bugs.

Given the choice:

1. [TypeScript](https://en.wikipedia.org/wiki/TypeScript) by Microsoft
2. The <a href="https://en.wikipedia.org/wiki/Go_(programming_language)">Go language</a> (aka golang) by Google

<div class="side-by-side">
<img title="TypeScript" src="https://s.natalian.org/2022-01-23/480px-Typescript_logo_2020.svg.png" alt="Typescript logo">
<img title="Go language" src="https://s.natalian.org/2022-01-23/640px-Go_Logo_Blue.svg.png" alt="Go logo">
</div>

What are the arguments for and against?

# Pros of Typescript

1. Assumed easier migrate an existing Javascript code base, doesn't require a
   "rewrite". However the process of getting **Javascript 100% migrated** isn't
   as crystal clear as it might be if you used Go.

# Cons of Typescript

> TypeScript is a scripting language for C#

1. Tied to the [Microsoft ecosystem](https://en.wikipedia.org/wiki/TypeScript)
2. Package dependencies are a mess, some have Typescript bindings, some don't. Lots of blind spots.
3. Lots of churn and difficult choices need to made <abbr title="with respect to">wrt</abbr> tooling
4. Different Javascript styles can make the code base confusing
5. Slow
6. Some argue that **Javascript with JSDoc is a better approach**
7. Constant one-off bugs from unmigrated code

# Pros of Golang

1. **Simple**, well-designed end to end ecosystem supported by Google
2. [Better error handling](https://youtu.be/7Q571BSR7wY)
3. **Faster** performance
4. Far [better package](https://research.swtch.com/npm-colors) design
5. **Easier to maintain** in the long run
6. Produces static binaries which are easier to deploy
7. Go can be learned in a weekend
8. [Moving between Javascript and Golang is actually suprisingly simple](https://youtu.be/jtCvOcFLtXU?t=433)

# Cons of Golang

> The biggest con of Go isn’t that people don’t know it - it’s that they refuse
> to learn it. They’ll die with a cold, hard grip on their overly-complicated
> polymorphic inheritance systems and useless utility libraries.

1. Less people know Go than Javascript
