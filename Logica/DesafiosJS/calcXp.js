const print = (name, level) => {
  console.log(`O Herói de nome ${name} está no nível de ${level}`);
};

const calculateXp = (name, experience) => {
  const level = {
    1000: "Ferro",
    2000: "Bronze",
    5000: "Prata",
    7000: "Ouro",
    8000: "Platina",
    9000: "Ascendente",
    10000: "Imortal",
  };

  let heroLevel = "Imortal"; 

  for (const k of Object.keys(level).map(Number).sort((a, b) => a - b)) {
    if (experience < k) break;
    heroLevel = level[k];
  }

  print(name, heroLevel);
};

calculateXp("Lucas", 10100);
calculateXp("Lucas", 7500);
