# Exercise 5 — React Pokédex

## Description

In this project, you'll be creating a frontend that graphically displays Pokémon information (similiar to a Pokédex). To fetch all the necessary information, you'll be working with the [PokeAPI](https://pokeapi.co/docs/v2#pokemon).

## Setting Up

- Make sure your repo is up to date
- Navigate to your forked repo
- Navigate to `exer5`
- Run `npx create-react-app pokedex` in your terminal
- Navigate to the created `pokedex` directory
- Run `npm start` to see the local server for the web app!

- Helpful Advice: Creating a `components` folder in the `src` directory can help with organization and clutter!

# Submission Instructions

- Create a 0.5-3 minute video walkthrough of your project (include the video link in the README of your project repo)
- Push all your changes to the remote repository.

## Requirements

- Must use HTML, CSS (or Tailwind CSS), JS, and React
- Must implement the `useState()` and `useEffect()` hooks
- Must contain the specified frontend elements
- Must use the free PokeAPI
- Should have at least 20 commits (though not required)

## Project Specifications

**What the end result should look like:**

<img width="500" alt="Screenshot 2023-09-26 at 5 41 02 PM" src="https://github.com/BoG-Dev-Bootcamp-S24/bootcamp-s24/blob/main/exer5/assets/info_screen.jpeg?raw=true">
<img width="500" alt="Screenshot 2023-09-26 at 5 41 09 PM" src="https://github.com/BoG-Dev-Bootcamp-S24/bootcamp-s24/blob/main/exer5/assets/moves_screen.jpeg?raw=true">

**GIF of interactions**
<br>
![](https://github.com/BoG-Dev-Bootcamp-S24/bootcamp-s24/blob/main/exer5/assets/Exer5_example.gif)

### General Guidelines

You should try to follow the mockups as closely as possible (including the alignments). The Figma designs can be found [here](https://www.figma.com/file/FuH7N8hWLw1UGoybZsLtNM/Bits_Of_Good_Exercise_5?type=design&node-id=0%3A1&mode=design&t=6K9yoFlC0fMsQIbW-1).

This project is designed to replicate real Bits of Good developer work. Typically, developers are given mockups by designers and are tasked with implementing them in code.

### API Fetches

You will be pinging the PokeAPI using `fetch()`. Refer to the [PokeAPI docs](https://pokeapi.co/docs/v2#pokemon) for more details about endpoints and JSON response formats. You can also view your requests at <https://pokeapi.co/>.

### Suggested endpoint

- <https://pokeapi.co/api/v2/pokemon/*YOUR_POKEMON_NAME_OR_DEX_NUMBER*/>
- This endpoint returns a JSON object for the proceeding pokemon in the url
- It will supply all the information you need for this exercise, including:
  - Pokemon Sprite
  - Pokemon Type
  - Pokemon Moves
  - Pokemon Stats
  - Pokemon Name
- Example: This code is to showcase a way to get the information for a pokemon. This is NOT the only way! Make sure to think about what hooks would be appropriate for the dex information!

  ```
  const URL = "https://pokeapi.co/api/v2/pokemon"; //Put the url for the endpoint into a variable for readability and convenience :)

  /*
  This function fetches the JSON for the specified pokemon and returns it.
  */
  const getPokemonJSON = async (dexNumber) => {
      try {
          const response = await fetch(`${URL}/{dexNumber}/`); //A string template literal; basically a more readable way to put variables in a string
          const pokemonJSON = await response.json();
          return pokemonJSON;
      } catch(e) {
          throw e;
      }
  }

  const pokemonJSON = getPokemonJSON(1); //bulbasaur
  
  /*
  The following are the keys for the returned JSON that you would probably find useful. NOTE: You might need to use the taught JS methods to get
  the information you need. These are just starting points!
  */
  const pokemonTypes = pokemonJSON.types; //array of objects
  const pokemonMoves = pokemonJSON.moves; //array of objects
  const pokemonSprite = pokemonJSON.sprites; //object with different img urls
  const pokemonStats = pokemonJSON.stats; //array of objects
  const pokemonName = pokemonJSON.name; //string
  const pokemonHeight = pokemonJSON.height; //number
  const pokemonWeight = pokemonJSON.weight; //number
  const pokemonDexNumber = pokemonJSON.order; //number
  
  ```

### Arrow Buttons

<img width="324" alt="Screenshot 2023-09-26 at 5 41 48 PM" src="https://github.com/BoG-Dev-Bootcamp-F23/project1-f23/assets/8647920/45f00173-3fac-4ac8-bf4c-e3cffd00c92f?raw=true">

These buttons control the ID number of the Pokémon you are currently displaying. Whenever a user clicks on these buttons, the ID number should be incremented/decremented, and the other components should be updated accordingly (to achive this, you'd want to create an HTTP request every time the buttons are clicked to fetch the data for the next Pokémon, think about which React Hook this follows!).

Note: be careful about querying an id number that doesn't exist (e.g. 0).

### Pokémon Identifiers (Image, Name, Types)

<img width="264" alt="Screenshot 2023-09-26 at 5 42 00 PM" src="https://github.com/BoG-Dev-Bootcamp-F23/project1-f23/assets/8647920/54923f99-0eef-4f13-a26d-cd3df259be06">

These should update automatically as a user clicks on the arrow buttons. All of the necessary data is available in the response to the HTTP request.

#### Pokémon Types

For however many types a Pokémon has, display all of them horizontally. Each type should correspond with a different color. The [official hex colors](https://www.epidemicjohto.com/t882-type-colors-hex-colors) for each type are:

<img width="153" alt="Screenshot 2023-09-26 at 5 42 21 PM" src="https://github.com/BoG-Dev-Bootcamp-F23/project1-f23/assets/8647920/27cd1982-094d-42d4-88f7-28f99e4598f9">

### Info/Moves Buttons

<img width="374" alt="Screenshot 2023-09-26 at 5 42 39 PM" src="https://github.com/BoG-Dev-Bootcamp-F23/project1-f23/assets/8647920/061ff1b1-82eb-4af9-9909-eeef3835a578">

The color of the buttons should differ based on whichever one is currently active (i.e. if the info is showing, then the info button should be green, etc.). Clicking each button should change whether the info or moves button is showing.

The selected setting should remain the same when the user switches between Pokémon using the arrows.

### Stats Panel

#### Info

<img width="269" alt="Screenshot 2023-09-26 at 5 42 56 PM" src="https://github.com/BoG-Dev-Bootcamp-F23/project1-f23/assets/8647920/24a2cd97-332c-493d-ab21-afa6e6e1f25c">

This panel should change accordingly as the user switches between Pokémon. Make sure the units are being displayed correctly — for example, the height stat is returned as an integer from the API but the units are in 0.1m.

#### Moves

<img width="270" alt="Screenshot 2023-09-26 at 5 43 05 PM" src="https://github.com/BoG-Dev-Bootcamp-F23/project1-f23/assets/8647920/3dc9263e-0d10-4e9d-9f54-06f3ab90819a">

Like the info panel, the moves should change accordingly as the user switches between Pokémon. This panel should simply list the names of all the Pokémon's moves.
