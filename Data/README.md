# Data Layer

Bridges external data sources with the Domain layer.

Structure:

- **Repositories/** – Concrete classes that implement the protocols declared in `Domain`. They transform DTOs ↔︎ Entities.
- **DataSources/**
  • _Remote_ (REST, GraphQL, WebSocket, etc.)
  • _Local_ (CoreData, Realm, UserDefaults, Cache)

Guidelines:

1. Keep business rules in Domain; the Data layer only fetches, persists and maps.
2. Networking and persistence frameworks live exclusively here.
3. Avoid exposing third-party types to Domain; map them to Entities.
