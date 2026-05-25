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
/// `Element` is `~Copyable` (so `Single<MoveOnly>` is itself move-only, while `Single<Int>` is
/// copyable) but must be `Escapable`: a non-escaping value cannot be stored durably in a
/// container that outlives the borrow it represents.
public struct Single<Element: ~Copyable>: ~Copyable {
    /// The stored element. Reading it *borrows* the container, so a move-only element can be
    /// observed repeatedly without being consumed.
    public var element: Element

    /// Construct a container holding `element`.
    @inlinable
    public init(_ element: consuming Element) {
        self.element = element
    }
}
