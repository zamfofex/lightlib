lightlib closing notes
===

It was already more than clear that lightlib was informally abandoned by now, though now it is formally admitted.

I have recently picked Agda hacking back up again after around a year, now (hopefully) doing things more normally than before. (Though “normally” is not particularly well defined in Agda, I think.)

Thinking about lightlib still makes me feel extremely nostalgic about the time I was interested about learning about Agda and dependent types. I never really had a proper use for what I learned, but it was extremely fun for me to learn about it, and it made me really happy!

The goal of lightlib was to solve problems I was facing when writing Agda programs at the time. Some of which seem to be common among Agda hackers, but some seem to only be related to my weird coding style at the time. Some of which were even fictitious — problems I deemed potential, but that people didn’t actually experienced for some reason or another.

Whether or not the solutions I came up with were justified at all, I was really happy about them, as they felt satisfying to me. Some things I was really proud of include:

<details>
<summary> Separating implementation from their definitions </summary>

With more experience, I can now see that this is actually very similar to the way things are done in C, where declarations (macros, prototypes, types) are kept in header files, separate from their definitions.

Of course, the reason for that in C is completely different from lightlib, but I realized the cases are extremely analogous at least.

The big advantage of that in Agda is allowing people to decide which properties of their programs they want to expose. By default, the entire definition is observable to outside modules, but that takes away a lot of flexibility with how the implementation can change over time.

With dependent types, where the one of the the main premises is being able to formally prove properties of programs, people have grown accustomed to that limitation, but I felt like there should be a better way.

One of the goals of lightlib was to allow people to choose which properties of their programs they deem important and want to keep supporting and which they deem to be an implementation detail that they might want to change in future versions without breaking backward compatibility.

Of course, this is a rather subjective characteristic of properties, and I had no good criteria to help decide, but given a formed decision, lightlib provided a (somewhat) clean approach to handle it.

</details>
<details>
<summary> Abstracting over implementations </summary>

This is a solution to one of those “fictitious problems” I mentioned, where it never actually occurred in practice, but it had the potential to.

I feel it never really occurs only because Agda is not a very popular language and because it doesn’t have many popular base libraries.

The idea was to allow people to write programs (likely libraries) that would worked well with multiple base libraries, and allow for them to be switched easily, so that users of those programs could choose which base library better fits their needs.

Even though that was an interesting idea, the lack of interest for such a feature caused for it to never really be anywhere near complete.

I thought it would be to encourage people to also provide their own implementations for the definitions given in lightlib, but on retrospect, that feels like a fragile architecture, because then new definitions couldn’t be added without risking ruining backwards compatibility.

</details>
<details>
<summary> Abstracting over relation types </summary>

One of the biggest pain points I have always encountered with Agda was how dauntingly repetitive it can get.

You can write an n‐ary relation idiomatically using data types or record types, but then you also need to write the accompanying decidability proofs, which is very similar in shape to the `Set` version, but still discrepant enough to have its own intricacies.

With lightlib, though I don’t think I had fully figured out the whole idea back then, the encouraged way to write relations would be to write it polymorphically to its type (propositional vs. decidable).

Thus, the relation would be both a proposition and a proof of its own decidability, given the correct concrete arguments passed to it (or its module as telescope arguments).

The proof of the proposition associated with the proof of decidability could also be dropped if unecessary by applying the correct arguments to concretize it as a boolean relation.

</details>

I don’t think the ideas behind lightlib were ever perfect or fully thought‐out, and a lot of the holes in my ideas showed up as I worked on it more thoroughly. But I was just happy to spend time trying to figure out how to design something different, taking a different approach than the norm and making something my own way. Also, I feel like a lot of it was hoping to solve legitimate problems that I was facing with learning Agda at the time.

Even though I was really proud of it, not many people really took an interest in lightlib, but some cared enough to bother taking a look and sharing feedback. Whether postive or negative, I’m really thankful to everyone who cared to be interested by my work!
