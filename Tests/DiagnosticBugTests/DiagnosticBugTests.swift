import DiagnosticBugMacros
import MacroTesting
import Testing

@Suite(.macros([DiagnosticBugMacro.self], record: .failed))
struct DiagnosticBugMacroTests {
    @Test
    func missingTypes() {
        assertMacro {
            """
            @DiagnosticBug
            struct Person {
                var age = 10
            }
            """
        } diagnostics: {
            """
            @DiagnosticBug
            struct Person {
                var age = 10
                    ┬───────
                    ╰─ ⚠️ Type should be defined explicitly.
                       ✏️ Insert type annotation.
            }
            """
        } fixes: {
            """
            @DiagnosticBug
            struct Person {
                var age :<#Type#>= 10
            }
            """
        } expansion: {
            """
            struct Person {
                var age :<#Type#>= 10
            }
            """
        }
    }
}
