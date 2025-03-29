const print = (wins, level) => {
  console.log(`O Herói de saldo de ${wins} está no nível de ${level}`);
};

const calculateVictories = (victory, loses) => {
  const myVictories = victory - loses;
  const level = {
    10: "Ferro",
    20: "Bronze",
    50: "Prata",
    80: "Ouro",
    90: "Platina",
    100: "Ascendente",
  };

  let heroLevel = "Imortal";

  for (const k of Object.keys(level).map(Number).sort((a, b) => a - b)) {
    if (myVictories < k) break;
    heroLevel = level[k];
  }

  print(myVictories, heroLevel);
};

calculateVictories(85, 10);
calculateVictories(95, 5);
calculateVictories(120, 10);
