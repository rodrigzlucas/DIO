const print = (wins, level) => {
  console.log(`O Herói de saldo de ${wins} está no nível de ${level}`);
};

const calculateVictories = (victory, loses) => {
  const myVictories = victory - loses;

  const level = {
    100: "Ascendente",
    90: "Platina",
    80: "Ouro",
    50: "Prata",
    20: "Bronze",
    10: "Ferro",
  };

  let heroLevel = "Imortal";

  for (const k of Object.keys(level)) {
    if (myVictories < k) break;
    heroLevel = level[k];
  }

  print(myVictories, heroLevel);
};

calculateVictories(85, 10);
calculateVictories(95, 5);
calculateVictories(120, 10);
