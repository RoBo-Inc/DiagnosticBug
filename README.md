# Diagnostic Bug

## Expected Behavior

To see the expected behavior, please refer to the `UnitTests` section.

## Actual Behavior

The warning appears only in the `Issue Navigator`, not in the `Editor` itself.

## Run

You can run the macro at the executable module `DiagnosticBugClient`.

## Fixes

Please refer to the macro implementation, lines #14-15.

## Note

This issue is not related to `SimpleDiagnosticMessage`, etc. In my actual macro, I use a completely different approach for diagnostic management, yet I still experience exactly the same bug.
