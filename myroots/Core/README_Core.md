# Core

Cross-cutting helpers and extensions shared by every layer.

Examples:

- `Color+Extensions.swift` (hex initialiser, design system colours)
- Logging utilities, Date / Formatter helpers
- Global constants, error types

Rules:

1. Keep dependencies lightweight. Prefer `Foundation` and avoid importing SwiftUI unless strictly UI-related.
2. No business logic; just utilities.
