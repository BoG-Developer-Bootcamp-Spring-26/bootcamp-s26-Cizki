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
