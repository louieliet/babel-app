# Coordinators

Responsible for assembling view hierarchies and handling navigation flow.

Each major feature can define its own coordinator:

- `AuthCoordinator`
- `ChatCoordinator`
- `MissionsCoordinator`

Coordinators own:

1. Creation & injection of ViewModels
2. Presentation/dismissal of child views
3. Communication back to parent coordinators via callbacks or Combine publishers.
