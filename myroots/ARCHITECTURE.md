# MyRoots Architecture

## Overview

This project follows Clean Architecture layered with MVVM and Coordinators in the Presentation layer. The structure is designed to scale while remaining straightforward for contributors.

### Layer Diagram

```text
App (SwiftUI)
└── RootCoordinator
    ├── FeatureCoordinator (Auth, Chat, Missions, …)
        ├── ViewModels
        │   └── SwiftUI Views
        └── UseCases ← Domain Layer
            └── Repository Protocols ← Domain Layer
                 ↙︎ ↑
Data Layer (Repositories) ——→ Remote & Local Data Sources
```

Arrows indicate the direction of dependencies. Higher layers depend only on abstractions provided by lower layers.

### Layers

1. **Presentation**
   • SwiftUI Views
   • ViewModels (`ObservableObject`)
   • Coordinators (navigation)

2. **Domain**
   • Entities & Value Objects (pure Swift types)
   • UseCases (business rules)
   • Repository protocols (interfaces only)

3. **Data**
   • Repository implementations
   • Remote data sources (network / WebSocket)
   • Local data sources (CoreData / Realm / Cache)

4. **Core**
   • Cross-cutting utilities, extensions, helpers

5. **Resources**
   • Asset catalogues, localisation, fonts, etc.

### Guiding Principles

• **Dependency Rule** – Cross-layer references always point inwards toward the Domain; the Domain never depends on outer layers.
• **Testability** – Domain and ViewModels remain free of framework code to enable fast unit tests.
• **Modularity** – Each major feature can evolve inside its own Swift Package when needed.
• **Scalability** – A minimal global AppState / Event Bus can be added later; not required for the current scope.

### Folder Layout

```text
Domain/
    ├─ Entities/
    └─ UseCases/

Data/
    ├─ Repositories/
    └─ DataSources/

Presentation/
    ├─ Views/
    ├─ ViewModels/
    └─ Coordinators/          # to be added when needed

Core/
    ├─ Extensions/
    └─ Utilities/

Resources/
```

### Contribution Workflow

1. Business logic → add/modify a UseCase in `Domain/UseCases`.
2. Persistence or networking → implement/extend a Repository in `Data/Repositories`.
3. UI changes → create/update a View and its ViewModel in `Presentation`.
4. Cross-cutting helpers → live in `Core`.

> Keep this document updated as the architecture evolves.
