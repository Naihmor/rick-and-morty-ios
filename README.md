# Rick & Morty in iOS

An MVP that lists Rick & Morty characters and shows detail using **SwiftUI** + **Swift Concurrency**,
CLEAN architecture (Presentation / Domain / Data), SOLID, and **no third-party libraries**.

## Targets
- iOS 17+ (Observation framework: `@Observable`, `@State`).
- REST via `URLSession`.

## Branching
- `main`: release
- `dev`: integración
- `feature/<slug>` → PR a `dev`

## Roadmap (short)
- Networking + DTOs → Repository + UseCases → List (pagination) → Detail.

## API
- https://rickandmortyapi.com/ (no API Key)
- REST endpoints: `/api/character`, `/api/episode`, `/api/location`

## Building
- Xcode 16 / iOS 17 SDK
- Open the Xcode project and run: `Cmd+R`.

## Tests
- `xcodebuild -scheme RickAndMortyApp -destination 'platform=iOS Simulator,name=iPhone 17' test`
