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
