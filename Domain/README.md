# Domain Layer

The heart of the application — pure Swift without any framework dependencies.

Contents:

- **Entities**: Immutable structs/value objects that represent core business concepts (e.g. `User`, `Message`, `Mission`, `MoodEntry`).
- **UseCases**: Stateless services that orchestrate business rules (e.g. `SendMessageUseCase`, `AssignMissionUseCase`).
- **Repository Protocols**: Interfaces that describe how data must be fetched or persisted. Implementations live in the Data layer.

Rules:

1. No `SwiftUI`, `UIKit`, or networking code here. Only `Foundation` is allowed.
2. Domain never depends on Data or Presentation. Those layers depend **on Domain**.
