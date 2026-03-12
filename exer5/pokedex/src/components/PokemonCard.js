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
