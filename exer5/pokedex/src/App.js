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
