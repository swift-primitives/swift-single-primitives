import Single_Primitives
import Testing

@Suite("Single Tests")
struct SingleTests {
    @Suite struct Unit {}
}

extension SingleTests.Unit {
    @Test
    func `stores and exposes a copyable element`() {
        let single = Single(42)
        #expect(single.element == 42)
    }

    @Test
    func `holds a move-only element, borrowable repeatedly`() {
        let single = Single(Token(7))
        // Multipass via borrow: read the move-only element more than once without consuming it.
        #expect(single.element.id == 7)
        #expect(single.element.id == 7)
    }

    @Test
    func `is copyable when its element is`() {
        let original = Single(42)
        let copy = original  // compiles only if Single<Int>: Copyable (conditional conformance)
        #expect(original.element == 42)
        #expect(copy.element == 42)
    }
}

private struct Token: ~Copyable {
    let id: Int
    init(_ id: Int) { self.id = id }
}
