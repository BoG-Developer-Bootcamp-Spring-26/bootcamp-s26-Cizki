import { useState, useEffect } from "react";
import "./App.css";
import PokemonCard from "./components/PokemonCard";
import InfoPanel from "./components/InfoPanel";
import MovesPanel from "./components/MovesPanel";

const URL = "https://pokeapi.co/api/v2/pokemon";

function App() {
  const [dexNumber, setDexNumber] = useState(1);
  const [pokemon, setPokemon] = useState(null);
  const [loading, setLoading] = useState(false);
  const [showInfo, setShowInfo] = useState(true);

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
    // dont let it go below 1
    if (dexNumber > 1) {
      setDexNumber(dexNumber - 1);
    }
  }

  function handleNext() {
    setDexNumber(dexNumber + 1);
  }

  return (
    <div className="app">
      <h1 className="title">Exercise 5 - PokeDex!</h1>

      {loading && <p className="loading-text">Loading...</p>}

      {!loading && pokemon && (
        <div className="main-layout">
          <div className="left-col">
            <PokemonCard pokemon={pokemon} />
            <div className="arrow-buttons">
              <button onClick={handlePrev} disabled={dexNumber <= 1} className="arrow-btn">
                {"<"}
              </button>
              <button onClick={handleNext} className="arrow-btn">
                {">"}
              </button>
            </div>
          </div>

          <div className="right-col">
            <h2 className="panel-title">{showInfo ? "Info" : "Moves"}</h2>
            <div className="panel-box">
              {showInfo ? <InfoPanel pokemon={pokemon} /> : <MovesPanel pokemon={pokemon} />}
            </div>
            <div className="tab-buttons">
              <button
                className="tab-btn"
                onClick={() => setShowInfo(true)}
                style={{ backgroundColor: showInfo ? "#6fdb6f" : "#e0e0e0" }}
              >
                Info
              </button>
              <button
                className="tab-btn"
                onClick={() => setShowInfo(false)}
                style={{ backgroundColor: !showInfo ? "#6fdb6f" : "#e0e0e0" }}
              >
                Moves
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

export default App;
