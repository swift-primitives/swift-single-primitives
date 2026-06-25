# Single Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

A single-element container — `Single<Element>`, storage that holds exactly one element and lends repeated access to it, including for move-only and non-escaping elements.

---

## Quick Start

`Single<Element>` *stores* its element and lends access to it. Unlike a single-element *iterator* — which owns the element and yields it once, consuming it — a container keeps its element for repeated, multipass access. `Element` is unconstrained (`~Copyable & ~Escapable`), so `Single` inherits its element's copyability and escapability: `Single<Int>` is an ordinary copyable value, `Single<MoveOnly>` is itself move-only, and `Single` over a non-escaping element is itself `~Escapable`.

```swift
import Single_Primitives

// A copyable element: Single<Int> is itself copyable.
let one = Single(42)
print(one.element)        // 42

let copy = one            // compiles because Single<Int>: Copyable
print(copy.element)       // 42
```

A move-only element is read by *borrowing* the container, so it can be observed more than once without being consumed:

```swift
import Single_Primitives

struct Token: ~Copyable {
    let id: Int
}

let single = Single(Token(id: 7))
print(single.element.id)  // 7
print(single.element.id)  // 7 — multipass via borrow, never moved out
```

`Single` is the shared one-element anchor onto which each domain attaches its conformance — the single-element sequence and collection (cf. the standard library's `CollectionOfOne`) — re-narrowing `Element` to whatever that domain requires.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-single-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Single Primitives", package: "swift-single-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

One library product, no dependencies.

| Product | Target | Purpose |
|---------|--------|---------|
| `Single Primitives` | `Sources/Single Primitives/` | `Single<Element>`: a container holding exactly one element, with conditional `Copyable` / `Escapable` conformances that mirror the stored element's capabilities. |

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
