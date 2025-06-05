import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros

public struct DiagnosticBugMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        _ = StructDeclSyntax(declaration)!.memberBlock.members.compactMap { $0.decl.as(VariableDeclSyntax.self) }.flatMap { decl in
            decl.bindings
                .filter { _ in true } // ⚠️ Comment this line out in order to get the expected behavior 🤯
        }.map { binding -> () in
            if binding.typeAnnotation?.type == nil {
                let diag = Diagnostic(
                    node: binding,
                    message: SimpleDiagnosticMessage(
                        message: "Type should be defined explicitly.",
                        diagnosticID: .init(domain: "Init", id: "MissingTypeAnnotation"),
                        severity: .warning
                    ),
                    fixIts: [
                        FixIt(
                            message: SimpleDiagnosticMessage(
                                message: "Insert type annotation.",
                                diagnosticID: .init(domain: "Init", id: "MissingTypeAnnotation"),
                                severity: .warning
                            ),
                            changes: [
                                FixIt.Change.replace(
                                    oldNode: .init(binding),
                                    newNode: .init(binding.with(\.typeAnnotation, .init(type: IdentifierTypeSyntax(name: .identifier("<#Type#>")))))
                                )
                            ]
                        )
                    ]
                )
                context.diagnose(diag)
                return
            }
            return
        }
        return []
    }
}

struct SimpleDiagnosticMessage: DiagnosticMessage, Error {
    let message: String
    let diagnosticID: MessageID
    let severity: DiagnosticSeverity
}

extension SimpleDiagnosticMessage: FixItMessage {
    var fixItID: MessageID { diagnosticID }
}
