# OMPokemon
SwiftUI app to browse and view Pokemon fetched using the PokéAPI.

## Project structure

Main Repository
 - |- OMPokemon                   -> Main App
 - |- OMNetworking                -> Package containing network layer
 - |- OMModels                    -> Package Containing model objects used by other components

### OMPokemon Structure

- |- OMPokemon (Pokedex App code)
- |- OMPokemon.xcodeproj (Pokedex App project file)
- |- OMPokemonTests (Test project with tests for logic of the main app)
- |- OMPokemonUITests (Test project with tests for the UI of the main app)

## Language
Swift 5.0

## Development Platform
Xcode 16.1

## Testing Framework
SwiftTesting

## Architecture

MVVM For UI
Factory for Dependency Injection (https://github.com/hmlongco/Factory)
Swift Package Manager For Dependency Management


## Future Enchancements

- Add UI Tests for the main app
- Introduce a UI package for reusable views
- Introduce a Util package for reusable utility logic
- Add xcconfig file for configuration variables
- Add infinite scrolling using paging for HomeView
- Split out network calls into Use Cases

