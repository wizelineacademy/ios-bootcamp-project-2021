# Code Review Rubric

This document lays out common criteria used to review Wizeliner code (in order of importance).

| Criterion | Excellent | Good | Adequate | Developing |
|---|---|---|---|---|
| **Program Specifications / Correctness** | No errors, program always works correctly and meets the specification(s). | Minor details of the program specification are violated, program functions incorrectly for some inputs. | Significant details of the specification are violated, program often exhibits incorrect behavior. | Program only functions correctly in very limited cases or not at all. |
| **Readability** | No errors, code is clean, understandable, and well-organized. | Minor issues with consistent indentation, use of whitespace, variable naming, or general organization. | At least one major issue with indentation, whitespace, variable names, or organization. | Major problems with at three or four of the readability subcategories. |
| **Code Efficiency** | No errors, code uses the best approach in every case. | N/A | Code uses poorly-chosen approaches in at least one place. | Many things in the code could have been accomplished in an easier, faster, or otherwise better fashion. |
| **Documentation** | No errors, code is well-commented. | One or two places that could benefit from comments are missing them or the code is overly commented. | File header missing, complicated lines or sections of code uncommented or lacking meaningful comments. | No file header or comments present. |
| **Assignment Specifications** | No errors | N/A | Minor details of the assignment specification are violated, such as files named incorrectly or extra instructions slightly misunderstood. | Significant details of the specification are violated, such as extra instructions ignored or entirely misunderstood. |

### Program Specifications / Correctness

This is the most important criterion. A program must meet its specifications and function correctly. This means that it behaves as desired, producing the correct output, for a variety of inputs.

### Readability
Code needs to be readable to both you and a knowledgeable third party. This involves:

* Using indentation consistently (e.g., every method's body is indented to the same level)
* Adding whitespace (blank lines, spaces) where appropriate to help separate distinct parts of the code (e.g., space after commas in lists, blank lines between methods or between blocks of related lines within methods, etc.)
* Giving variables meaningful names. Variables named `A`, `B`, and `C` or `foo`, `bar`, and `baz` give the reader no information whatsoever about their purpose or what information they may hold. Names like `principal`, `maximum`, and `counter` are much more useful. Loop variables are a common exception to this idea, and loop variables named `i`, `j`, etc. are okay.
* The code should be well organized. Methods should be defined in one section of the program, code should be organized into methods so that blocks of code that need to be reused are contained within methods to enable that, and methods should have meaningful names.

Please refer to the 
- [Wizeline Style Guide](https://github.com/wizeline/mobile-documentation/blob/master/guidelines/swift-style-guide.md) 
- [RayWenderlich Style Guide](https://github.com/raywenderlich/swift-style-guide)

For an idea of what 'Excellent' readability might look like.

### Documentation

Every file containing code should start with a header comment. At the very least, this header should contain the name of the file, a description of what the included code does, and the name of its author (you). Other details you might include are the date it was written, a more detailed description of the approach used in the code if it is complex or may be misunderstood, or references to resources that you used to help you write it.

All code should also be well-commented. This requires striking a balance between commenting everything, which adds a great deal of unneeded noise to the code, and commenting nothing, in which case the reader of the code (or you, when you come back to it later) has no assistance in understanding the more complex or less obvious sections of code. In general, aim to put a comment on any line of code that you might not understand yourself if you came back to it in a month without having thought about it in the interim.

### Code Efficiency
There are often many ways to write a program that meets a particular specification, and several of them are often poor choices. They may be poor choices because they take many more lines of code (and thus your effort and time) than needed, or they may take much more of the computer's time to execute than needed. For example, a certain section of code can be executed ten times by copying and pasting it ten times in a row or by putting it in a simple for loop. The latter is far superior and greatly preferred, not only because it makes it faster to both write the code and read it later, but because it makes it easier for you to change and maintain.

### Assignment Specifications

Assignments will usually contain specifications and/or requirements outside of the programming problems themselves. For example, the way you name your files to submit them to the course website will be specified in the assignment. Other instructions may be included as well, so please read the assignments carefully.
