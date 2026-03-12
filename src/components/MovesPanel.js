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
