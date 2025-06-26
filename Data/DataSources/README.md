# DataSources

Low-level interfaces that talk to the outside world.

Subfolders (suggested):

- **Remote/** – REST/GraphQL/WebSocket clients
- **Local/** – CoreData, Realm, UserDefaults, Filesystem caches

DataSources should not expose their concrete models outside the Data layer.
