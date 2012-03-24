---
layout: post
title:  Return-Oriented Programming - Systems, Languages, and Applications
description: The ACM Transactions of Information and System Security (TISSEC)
  recently published a paper I co-authored with some UCSD folks in grad school
  discussing the creation and evolution of return-oriented programming,
  a computer exploit designed to defeat certain classes of systems security.
date: 2012-03-24 16:40:56 UTC
tags: ['return oriented programming', 'security', 'exploits',
       'acm', 'tissec', 'ucsd']
---

## Return-Oriented Programming

[Return-oriented programming][rop] is a software exploit technique to take
over a program by diverting control flow without injecting any code. At UCSD,
I did most of my graduate research around this specific attack, working with
[Erik Buchanan][erik], [Hovav Shacham][hovav], and [Stefan Savage][stefan].
Now three years later, the ACM Transactions of Information and System Security
(TISSEC) journal has published our full article,
"[Return-Oriented Programming: Systems, Languages, and Applications][pub]"
in the March 2012 issue.

For a great introduction to return-oriented programming attacks, see
Hovav's Black Hat presentation,
"[Return-oriented Programming: Exploitation without Code Injection][bh]".

By way of a little background, software exploit techniques such as buffer
overflows traditionally injected code into a vulnerable buffer, and then
pointed control to that injected code whereby the attacker executed their own
instructions. The original attack was succinctly described in Aleph One's
"[Smashing The Stack For Fun And Profit][aleph]".

Software vendors responded to injected code attacks with various defenses, one
popular being "write XOR execute" ("W&oplus;X"), whereby memory is either
writable (e.g., data structure storage) or executable (e.g., library code), but
**not both**. The logic behind the defense was that an attacker could inject
arbitrary data in writable memory but could not execute it, thus preventing
the classic type of buffer overflow attack.

However, preventing code *injection* is not sufficient to prevent arbitrary
*computation*. Following a long line of W&oplus;X exploit research,
return-oriented programming works by taking existing executable code (e.g.,
loaded libraries) and using small chunks of it in unintended ways by hijacking
control flow via compromising the stack or writable memory.

<!-- more start -->

## Return-Oriented Programming: Systems, Languages, and Applications

Erik and I became interested in return-oriented programming when we read
Hovav's paper that introduced the technique,
"[The Geometry of Innocent Flesh on the Bone: Return-into-libc without Function Calls (on the x86).][geom]".
Hovav focused on the x86 architecture and hypothesized
that the attack would possibly be mitigated on a RISC architecture.

Fortunately, Erik and I were both TA's for the SPARC (a RISC architecture)
assembly programming course for undergraduates, and figured we could apply the
attack further than originally anticipated. We were extremely lucky to get
Hovav on board with our research and to later succeed in porting the attack
to the SPARC architecture. We presented our findings in a paper at the 2008
[ACM Conference on Computer and Communications Security][ccs] (CCS). We
were later invited to turn our conference paper into a full journal paper
for TISSEC.

We essentially coalesced both the x86 and SPARC research to be the definitive
statement on return-oriented programming, and submitted our draft in early
2009. Academic publishing does not always move at the most rapid pace, and it
took about three years to finally get "Return-Oriented Programming: Systems,
Languages, and Applications" published.

I think the paper is a good statement of the original development and first
level extensions of the attack (and I'm obviously biased in recommending it,
as I'm an author). But, it is worth pointing out that a **lot** has happened
in the time since we submitted our draft, and the state of the art in
return-oriented programming has advanced *significantly* past that described
in our paper. Since our original research, the attack has found its way into
[voting machines][vote], [routers][routers], [mobile devices][ios] and other
places. It is fascinating (and scary) to see the ways in which this attack
technique has now entered the mainstream, but I'm at least happy to have (in
a small way) helped expose the problem to software vendors early to give
them a chance to build up defenses against return-oriented programming.

[erik]: http://ucsd.erikbuchanan.com/
[hovav]: http://cseweb.ucsd.edu/~hovav/
[stefan]: http://cseweb.ucsd.edu/~savage/
[ios]: http://www.theregister.co.uk/2011/08/04/secret_iphone_hacking_tool/
[routers]: http://www.slideshare.net/amiable_indian/cisco-ios-attack-defense-the-state-of-the-art
[vote]: http://www.sciencedaily.com/releases/2009/08/090810161902.htm
[ccs]: http://www.sigsac.org/ccs/CCS2008/
[geom]: http://cseweb.ucsd.edu/~hovav/papers/s07.html
[bh]: http://cseweb.ucsd.edu/~hovav/dist/blackhat08.pdf
[pub]: http://dl.acm.org/citation.cfm?id=2133377
[rop]: http://en.wikipedia.org/wiki/Return-oriented_programming
[aleph]: http://insecure.org/stf/smashstack.html

<!-- more end -->
