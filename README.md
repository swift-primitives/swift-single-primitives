# swift-single-primitives

A single-element container — `Single<Element>`, storage that holds exactly one element.

`Single` *stores* its element and lends access to it. Unlike a single-element *iterator*
(which owns the element and yields it once, consuming it), a container keeps its element for
repeated, multipass access — including for move-only elements, which are read by *borrowing*
(never copied or moved out). It is the shared one-element anchor onto which each domain
attaches its conformance — the single-element sequence and collection (cf. the standard
library's `CollectionOfOne`). `Element` is `~Copyable` but must be `Escapable`.

    import Single_Primitives

    let one = Single(42)
    // one.element == 42

## License

Apache 2.0.
