---
title: Javascript vs Golang
date: 2022-01-19T09:40:48+08:00
description: Pros and Cons from moving from Ecmascript to Go
---

# Strongly typed

A Javascript project needs to adopt strong typing to improve quality and avoid
bugs.

We have a choice:

1. Typescript
2. Golang

# Pros of Typescript

1. Easier to migrate an existing Javascript code base, doesn't require a "rewrite"

# Cons of Typescript

1. Tied to the Microsoft ecosystem
2. Package dependencies are a mess, some have Typescript bindings, some don't
3. Lots of churn and difficult choices need to made wrt tooling
4. Different Javascript styles can make the code base confusing
5. Slow

# Pros of Golang

1. **Simple**, well-designed end to end ecosystem supported by Google
2. Better error handling
3. **Faster** performance
4. Far [better package](https://research.swtch.com/npm-colors) design
5. **Easier to maintain** in the long run
6. Produces static binaries which are easier to deploy

# Cons of Golang

1. Less people know Go than Javascript
