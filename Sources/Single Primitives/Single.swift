public struct Single<Element: ~Copyable & ~Escapable>: ~Copyable, ~Escapable {

    public var element: Element

    @inlinable
    @_lifetime(copy element)
    public init(_ element: consuming Element) {
        self.element = element
    }
}

extension Single: Copyable where Element: Copyable & ~Escapable {}

extension Single: Escapable where Element: Escapable & ~Copyable {}
