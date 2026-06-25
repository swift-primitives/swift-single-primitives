//
//  Single.swift
//  swift-single-primitives
//

/// A container holding exactly one element.
///
/// `Single<Element>` *stores* its element and lends access to it. Unlike a single-element
/// *iterator* (which owns the element and yields it once, *consuming* it), a container keeps
/// its element for repeated, multipass access — including for move-only elements, which are
/// read by *borrowing* the container (never copied or moved out), which is multipass-safe.
///
/// `Single` is the shared one-element anchor onto which each domain attaches its conformance:
/// the single-element sequence and collection (cf. the standard library's `CollectionOfOne`).
/// The matching single-element *iterator* — owns the element, yields it once — is a separate
/// type.
///
/// `Element` is unconstrained — `~Copyable & ~Escapable`. `Single` inherits both capabilities
/// from what it stores: `Single<Int>` is copyable, `Single<MoveOnly>` is itself move-only, and
/// `Single` over a non-escaping element is itself `~Escapable`, its lifetime bound to the
/// element's — so the container never outlives the borrow a non-escaping element represents,
/// which is exactly why it can hold one. Each domain's conformance re-narrows `Element` to
/// whatever that domain actually requires.
public struct Single<Element: ~Copyable & ~Escapable>: ~Copyable, ~Escapable {
    /// The stored element.
    ///
    /// Reading it *borrows* the container, so a move-only element can be observed repeatedly
    /// without being consumed.
    public var element: Element

    /// Construct a container holding `element`.
    @inlinable
    @_lifetime(copy element)
    public init(_ element: consuming Element) {
        self.element = element
    }
}

// `Single` inherits its element's capabilities. These conditional conformances restore each
// capability that the `~Copyable` / `~Escapable` declaration suppresses, so `Single<Int>` is an
// ordinary copyable, escapable value, `Single<MoveOnly>` stays move-only, and `Single` over a
// non-escaping element stays `~Escapable`.
extension Single: Copyable where Element: Copyable & ~Escapable {}

extension Single: Escapable where Element: Escapable & ~Copyable {}
