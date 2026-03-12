import { useState, useEffect } from "react";
import "./App.css";

const URL = "https://pokeapi.co/api/v2/pokemon";

function App() {
  const [dexNumber, setDexNumber] = useState(1);
  const [pokemon, setPokemon] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    setLoading(true);
    fetch(`${URL}/${dexNumber}/`)
      .then((res) => res.json())
      .then((data) => {
        setPokemon(data);
        setLoading(false);
      })
      .catch((err) => {
        console.log(err);
        setLoading(false);
      });
  }, [dexNumber]);

  function handlePrev() {
    if (dexNumber > 1) {
      setDexNumber(dexNumber - 1);
    }
  }

  function handleNext() {
    setDexNumber(dexNumber + 1);
  }

  return (
    <div className="app">
      <h1>Exercise 5 - PokeDex!</h1>
      <div>
        <button onClick={handlePrev}>{"<"}</button>
        <button onClick={handleNext}>{">"}</button>
      </div>
      {loading && <p>Loading...</p>}
      {!loading && pokemon && <p>{pokemon.name}</p>}
    </div>
  );
}

export default App;
