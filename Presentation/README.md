# Presentation Layer

User-facing code: SwiftUI views, their view models, and the coordinators that manage navigation.

Folders:

- **Views/** – Pure UI declarations; stateless apart from `@State` used for animations or view-local flags.
- **ViewModels/** – `ObservableObject`s that expose data via `@Published` and call UseCases.
- **Coordinators/** – Objects (to be added) responsible for assembling flows and handling navigation.

Guidelines:

1. Views depend only on their ViewModel; they never talk directly to UseCases or Repositories.
2. ViewModels receive dependencies via initialisers (injected by Coordinators).
3. Keep the layer free of networking or database code.
