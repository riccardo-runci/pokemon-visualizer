# Pokemon Visualizer
Just a simple Pokemon Visualizer, the app shows the list of all pokemon with their details through this [API](https://pokeapi.co).
Developed for Telepass digital iOS Test

## Installation
- Clone the repo
- Run pod install
- Build

Requirements:
- Use Swift 5.5 ✅ 
- Use iOS 11 as Target SDK ✅ 
- Use the MVVM pattern ✅ 
- The app’s UI must be dynamic and must support both iPhone and iPad without using XIBs or Storyboards ✅ 

Bonus Tasks:
- Use one external library at most ✅ 
  - I have only used the Alamofire SDK, simply because I am more familiar with it
- Make the app work seamlessly also offline ✅ 
  - The cache are managed through UserDefaults and FileManager
- Write Unit Tests ❌
- Personalize the project with something that may be useful to this app ✅ 
  - I added a simple bookmark management ⭐
  - Support for light and dark mode ⭐

## App explained
Structurally the app uses the MVVM pattern, with a Model that represents the data shown to the user, a ViewController that takes care of showing it to the user, and a ViewModel that work as a bridge and make the data management. The UI is completely managed without the use of Storyboards or XIBs (except for the launchscreen) and hierarchically has a main View that contains the bottom bar where the user can select to show the entire list of pokemon or his favorites. The main view has a container as a child where the view to be displayed is loaded. They both use the TableView to show the pokemon list to the user. I tried to make it as versatile and reusable as possible. When tapped on a pokemon, a modal is shown where the user can find the basic information of the pokemon and can add it to his favorites. API requests are made through the Alamofire library, just because I am faimiliar with it.
