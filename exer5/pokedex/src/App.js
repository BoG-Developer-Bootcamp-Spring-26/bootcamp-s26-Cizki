import { useState, useEffect } from "react";
import "./App.css";

const URL = "https://pokeapi.co/api/v2/pokemon";

function App() {
  const [dexNumber, setDexNumber] = useState(1);
  const [pokemon, setPokemon] = useState(null);

  useEffect(() => {
    fetch(`${URL}/${dexNumber}/`)
      .then((res) => res.json())
      .then((data) => {
        setPokemon(data);
        console.log(data);
      });
  }, [dexNumber]);

  return (
    <div className="app">
      <h1>Exercise 5 - PokeDex!</h1>
      {pokemon && <p>{pokemon.name}</p>}
    </div>
  );
}

export default App;
