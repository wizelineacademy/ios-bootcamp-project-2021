# iOS Apprenticeship Program 2020

## Table of Contents

* [Introduction](#introduction)
* [The Challenge](#the-challenge)
* [Requirements](#requirements)
* [Getting Started](#getting-started)
* [Deliverables](#deliverables)
* [TheMovieDb API](#themoviedb-api)

## Introduction

This Apprenticeship Program is looking for improve the iOS Technical skills. 
When the Wizeliner ends this program the expected level would be two or above according the current necessities.

Thank you for participating in the Apprenticeship Program 2020!.

Here, you'll find instructions to complete this program.

## The Challenge

The purpose of the challenge is for you to demonstrate your iOS skills.

This is your chance to show off everything you've learned during the program and to improve your Technical skills.

You will build and deliver a **whole** iOS application on your own.

We don't want to limit you by providing some fill-in-the-blanks exercises. Instead, we want you to build it from scratch. 

We hope you find this exercise challenging and engaging.

The goal is to build a `TheMovieDb` client app.

> \*_NOTE:_ Use `f6cd5c1a9e6c6b965fdcab0fa6ddd38a` as the api_key (Include this in your API calls!)\*

You should use this API just as a guide and as a trigger for your own ideas.
`It's not mandatory to use an especific UI component`. 
It is **YOUR** project and you can be creative in the way you build it.

### Requirements

These are the main requirements for your deliverable evaluation:

- Use all that you've learned in the course:
  - Swift best practices
  - Design Principles
    - SOLID
    - YAGNI
    - DRY
    - KISS
  - Design Patterns
  - Architectures
  - Dependency Injection
  - Unit Test
- Implement Unit Tests Coverage (~70%)

Try to keep the use of 3rd party libraries to the minimum, especially the ones related to the topics covered in the course.

For example, you can use some Image downloader framework (such as Kingfisher) if that makes you feel more comfortable and move faster. However, we will still want you to develop and deliver meaningful styled-components.

## Getting Started

We have provided an Xcode project in this repository.

The provided codebase is not directly related to the challenge topic, but you can use it as a guide for structuring your application. Feel free to add, remove, or change anything if you consider it necessary.

To get started, follow these steps:

**Step 1:** Follow the [TheMovieDb API](
https://developers.themoviedb.org/3/getting-started/introduction), you can create your own account or you can use this `f6cd5c1a9e6c6b965fdcab0fa6ddd38a` api key.

**Step 2:** After configuring the API key, you can read the [TheMovieDb API documentation](https://www.themoviedb.org/documentation/api) to get examples about how to consume the API.

**Step 3:** Create your own `main` branch `main-(your name)-(your lastname)`, example: main-steve-jobs

**Step 4:** Create your own `dev` branch `dev-(your name)-(your lastname)`,
example: dev-steve-jobs

**Step 5:** Create your task branches using `(your name)-(your lastname)-description`, example: steve-jobs-add-network-layer, you must create a PR for any new feature added to your project.

**Step 6:** Commit periodically.

**Step 7:** Configure [SwiftLint](https://github.com/realm/SwiftLint) in your project, this repository already contains a swiftlint file.

**Step 8:** Have fun!

## Deliverables

We provide the delivery dates so you can plan accordingly. Please, take this challenge seriously and try to make progress constantly.

It’s worth mentioning that you’ll ONLY get feedback from the review team for your first deliverable, so you will have a chance to fix or improve the code based on our suggestions.

For the final deliverable, we will provide some feedback, but there is no extra review date. If you are struggling with something, we will be happy to help you via the #ios-apprenticeship-2020 slack channel.

### First Deliverable 

- Home View
 
  - Show movies
     - Trending
      - Now Playing
      - Popular
      - Top Rated 
      - Upcoming

- Search movie or person.
  
  -  Display results by keyword and by query.

- Movie Details View

  - Display the selected movie and its information.
  - Display overview.
  - Display cast.
  - Display similar movies.
  - Display recommended movies.
  - Option to read reviews.

- Reviews View
  - Display reviews

> \*_Important:_ what’s listed in this deliverable is just for guidance and to help you distribute your workload; you can deliver more items if necessary.

### Final Deliverable 

- Finish any pending functionality or address any comment you receive from your previous deliverable.

- Unit Testing
  - Create tests for your application
  - Coverage must be at least `70%`

## Submitting the deliverables

For submitting your work, you should follow these steps:

- Create a pull request with your code. 
- Target your main branch of the repository [iOS-apprenticeship-program-2020](https://github.com/wizeline/iOS-apprenticeship-program-2020).


# TheMovieDb API

- Base Url:

```
https://api.themoviedb.org/3
```

- Trending [url](https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1)

```
/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1
```

- Now Playing [url](https://api.themoviedb.org/3/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1)
```
/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1
```

- Popular [url](https://api.themoviedb.org/3/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1)
```
/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1
```

- Top Rated [url](https://api.themoviedb.org/3/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=1&region=US)
```
/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=1&region=US
```

- Upcoming [url](https://api.themoviedb.org/3/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1)
```
/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1
```

- Keyword [url](https://api.themoviedb.org/3/search/keyword?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&query=Matrix)
```
/search/keyword?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&query=Matrix
```

- Search [url](https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=2&query=Matrix%20)
```
/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=2&query=Matrix%20
```

- Reviews [url](https://api.themoviedb.org/3/movie/603/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&language=en-US)
```
/movie/603/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&language=en-US
```

- Similar movies [url](https://api.themoviedb.org/3/movie/603/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en)
```
/movie/603/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en
```

- Recommendations [url](https://api.themoviedb.org/3/movie/603/recommendations?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en)
```
/movie/603/recommendations?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en
```


> \*_Important:_ Don't forget to include any additional information that might be necessary for running your code (for example, test user credentials, etc).
