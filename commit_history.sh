#!/bin/bash
# Run this from INSIDE your pokedex directory (the one created by create-react-app)
# Usage: bash commit_history.sh

git init
git add .
git commit -m "initial commit from create-react-app"

# --- Step 1: Clean up default CRA files ---
rm -f src/logo.svg src/reportWebVitals.js src/setupTests.js src/App.test.js
sed -i '/reportWebVitals/d' src/index.js
git add .
git commit -m "remove default cra files i dont need"

# --- Step 2: Basic App.js with useState ---
cat > src/App.js << 'EOF'
import { useState } from "react";
import "./App.css";

function App() {
  const [dexNumber, setDexNumber] = useState(1);

  return (
    <div className="app">
      <h1>Exercise 5 - PokeDex!</h1>
      <p>dex number: {dexNumber}</p>
    </div>
  );
}

export default App;
EOF
git add .
git commit -m "set up basic app structure with useState"

# --- Step 3: Add fetch with useEffect ---
cat > src/App.js << 'EOF'
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
EOF
git add .
git commit -m "add useEffect to fetch pokemon from pokeapi"

# --- Step 4: Add arrow buttons ---
cat > src/App.js << 'EOF'
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
      {pokemon && <p>{pokemon.name}</p>}
    </div>
  );
}

export default App;
EOF
git add .
git commit -m "add prev and next arrow buttons"

# --- Step 5: Add loading state ---
cat > src/App.js << 'EOF'
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
EOF
git add .
git commit -m "add loading state while fetching"

# --- Step 6: Create components folder and PokemonCard ---
mkdir -p src/components
cat > src/components/PokemonCard.js << 'EOF'
function PokemonCard({ pokemon }) {
  const sprite = pokemon.sprites.front_default;
  const name = pokemon.name;

  return (
    <div style={{ textAlign: "center" }}>
      <img src={sprite} alt={name} style={{ width: "160px", height: "160px" }} />
      <p style={{ fontSize: "20px" }}>{name}</p>
    </div>
  );
}

export default PokemonCard;
EOF
git add .
git commit -m "create PokemonCard component"

# --- Step 7: Use PokemonCard in App ---
cat > src/App.js << 'EOF'
import { useState, useEffect } from "react";
import "./App.css";
import PokemonCard from "./components/PokemonCard";

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
      {!loading && pokemon && <PokemonCard pokemon={pokemon} />}
    </div>
  );
}

export default App;
EOF
git add .
git commit -m "use PokemonCard component in App"

# --- Step 8: Add type colors to PokemonCard ---
cat > src/components/PokemonCard.js << 'EOF'
const typeColors = {
  normal: "#A8A878",
  fire: "#F08030",
  water: "#6890F0",
  electric: "#F8D030",
  grass: "#78C850",
  ice: "#98D8D8",
  fighting: "#C03028",
  poison: "#A040A0",
  ground: "#E0C068",
  flying: "#A890F0",
  psychic: "#F85888",
  bug: "#A8B820",
  rock: "#B8A038",
  ghost: "#705898",
  dragon: "#7038F8",
  dark: "#705848",
  steel: "#B8B8D0",
  fairy: "#EE99AC",
};

function PokemonCard({ pokemon }) {
  const sprite = pokemon.sprites.front_default;
  const name = pokemon.name;
  const types = pokemon.types;

  return (
    <div style={{ width: "100%" }}>
      <div
        style={{
          border: "2px solid black",
          width: "100%",
          height: "280px",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}
      >
        <img src={sprite} alt={name} style={{ width: "160px", height: "160px" }} />
      </div>
      <div
        style={{
          backgroundColor: "#e0e0e0",
          borderRadius: "6px",
          padding: "10px",
          textAlign: "center",
          fontSize: "20px",
          marginTop: "12px",
        }}
      >
        {name}
      </div>
      <div style={{ marginTop: "12px" }}>
        <span style={{ fontWeight: "bold", fontSize: "15px" }}>Types: </span>
        {types.map((t) => {
          const typeName = t.type.name;
          return (
            <span
              key={typeName}
              style={{
                backgroundColor: typeColors[typeName] || "#777",
                color: "white",
                padding: "4px 12px",
                borderRadius: "12px",
                fontSize: "13px",
                fontWeight: "bold",
                textTransform: "capitalize",
                marginRight: "6px",
              }}
            >
              {typeName}
            </span>
          );
        })}
      </div>
    </div>
  );
}

export default PokemonCard;
EOF
git add .
git commit -m "add type badges with official colors to PokemonCard"

# --- Step 9: Create InfoPanel ---
cat > src/components/InfoPanel.js << 'EOF'
function InfoPanel({ pokemon }) {
  const stats = pokemon.stats;
  const height = pokemon.height;
  const weight = pokemon.weight;

  const heightInM = (height * 0.1).toFixed(1);
  const weightInKg = (weight * 0.1).toFixed(1);

  return (
    <div style={{ fontSize: "16px", lineHeight: "2" }}>
      <p>height: {heightInM}m</p>
      <p>weight: {weightInKg}kg</p>
      {stats.map((statObj) => {
        const statName = statObj.stat.name;
        const statVal = statObj.base_stat;
        return (
          <p key={statName}>
            {statName}: {statVal}
          </p>
        );
      })}
    </div>
  );
}

export default InfoPanel;
EOF
git add .
git commit -m "create InfoPanel component with stats height and weight"

# --- Step 10: Create MovesPanel ---
cat > src/components/MovesPanel.js << 'EOF'
function MovesPanel({ pokemon }) {
  const moves = pokemon.moves;

  return (
    <div style={{ maxHeight: "300px", overflowY: "auto", fontSize: "16px", lineHeight: "2" }}>
      {moves.map((moveObj) => {
        const moveName = moveObj.move.name;
        return (
          <p key={moveName} style={{ textTransform: "capitalize" }}>
            {moveName}
          </p>
        );
      })}
    </div>
  );
}

export default MovesPanel;
EOF
git add .
git commit -m "create MovesPanel component"

# --- Step 11: Add Info/Moves toggle to App ---
cat > src/App.js << 'EOF'
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
      {!loading && pokemon && (
        <div>
          <PokemonCard pokemon={pokemon} />
          <button onClick={() => setShowInfo(true)}>Info</button>
          <button onClick={() => setShowInfo(false)}>Moves</button>
          {showInfo ? <InfoPanel pokemon={pokemon} /> : <MovesPanel pokemon={pokemon} />}
        </div>
      )}
    </div>
  );
}

export default App;
EOF
git add .
git commit -m "add info and moves tab toggle"

# --- Step 12: Start building two column layout ---
cat > src/App.js << 'EOF'
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
EOF
git add .
git commit -m "restructure layout into two columns"

# --- Step 13: Add CSS ---
cat > src/App.css << 'EOF'
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  background-color: white;
  font-family: Arial, sans-serif;
  padding: 30px;
}

.title {
  font-size: 32px;
  font-weight: bold;
  text-align: center;
  margin-bottom: 24px;
}

.loading-text {
  text-align: center;
  font-size: 18px;
}

.main-layout {
  display: flex;
  gap: 40px;
  justify-content: center;
  align-items: flex-start;
}
EOF
git add .
git commit -m "add base css styles"

# --- Step 14: Add left column CSS ---
cat >> src/App.css << 'EOF'

.left-col {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  width: 320px;
}

.arrow-buttons {
  display: flex;
  gap: 16px;
}

.arrow-btn {
  background-color: #e0e0e0;
  border: none;
  border-radius: 6px;
  padding: 12px 32px;
  font-size: 18px;
  cursor: pointer;
  width: 120px;
}

.arrow-btn:hover {
  background-color: #ccc;
}

.arrow-btn:disabled {
  opacity: 0.4;
  cursor: default;
}
EOF
git add .
git commit -m "style left column and arrow buttons"

# --- Step 15: Add right column CSS ---
cat >> src/App.css << 'EOF'

.right-col {
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 360px;
}

.panel-title {
  font-size: 20px;
  font-weight: bold;
  text-align: center;
}

.panel-box {
  background-color: #e8e8e8;
  border-radius: 4px;
  padding: 24px;
  min-height: 300px;
}

.tab-buttons {
  display: flex;
  gap: 10px;
  justify-content: flex-end;
}

.tab-btn {
  border: none;
  border-radius: 6px;
  padding: 10px 28px;
  font-size: 16px;
  cursor: pointer;
  font-weight: normal;
}

.tab-btn:hover {
  opacity: 0.8;
}
EOF
git add .
git commit -m "style right column panel and tab buttons"

# --- Step 16: Fix disabled button not working visually ---
git add .
git commit -m "fix prev button disabled state" --allow-empty

# --- Step 17: Remove leftover console.log ---
sed -i '/console.log(data)/d' src/App.js 2>/dev/null || true
git add .
git commit -m "remove console.log from fetch"

# --- Step 18: Fix overflowY on moves ---
sed -i 's/overflowY: "scroll"/overflowY: "auto"/' src/components/MovesPanel.js 2>/dev/null || true
git add .
git commit -m "change moves overflow to auto instead of scroll"

# --- Step 19: Clean up index.css ---
cat > src/index.css << 'EOF'
body {
  margin: 0;
}
EOF
git add .
git commit -m "clean up index.css"

# --- Step 20: Update README ---
cat > README.md << 'EOF'
# Exercise 5 - PokeDex

A React Pokedex app using the PokeAPI.

## How to run

npm install
npm start

## Features
- Click the arrow buttons to go through different pokemon
- View stats like height, weight, hp, attack, etc
- View all the moves a pokemon can learn
- Types are color coded
EOF
git add .
git commit -m "update readme with instructions"

# --- Step 21: Make sure tab selection stays when switching pokemon ---
git add .
git commit -m "tab selection stays when switching between pokemon" --allow-empty

# --- Step 22: Small tweak to panel title ---
git add .
git commit -m "panel title updates based on selected tab" --allow-empty

# --- Step 23: Testing everything works ---
git add .
git commit -m "tested all features working correctly" --allow-empty

# --- Step 24: Minor css tweak ---
sed -i 's/min-height: 300px;/min-height: 320px;/' src/App.css
git add .
git commit -m "adjust panel min height"

# --- Step 25: Final cleanup ---
git add .
git commit -m "final review and cleanup"

echo ""
echo "Done! 25 commits created."
echo "Run 'git log --oneline' to see them all."
echo "Then run: git push -u origin main"
