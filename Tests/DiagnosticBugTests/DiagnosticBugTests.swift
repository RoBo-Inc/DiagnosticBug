import DiagnosticBugMacros
import MacroTesting
import Testing

@Suite(.macros([StringifyMacro.self]))
struct StringifyMacroTests {
    @Test
    func stringify() {
        assertMacro {
            """
            #stringify(a + b)
            """
        } expansion: {
            """
            (a + b, "a + b")
            """
        }
    }
    
    @Test
    func stringifyLiteral() {
        assertMacro {
            #"""
            #stringify("Hello, \(name)")
            """#
        } expansion: {
            #"""
            ("Hello, \(name)", #""Hello, \(name)""#)
            """#
        }
    }
}
