import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct DiagnosticBugPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DiagnosticBugMacro.self,
    ]
}
