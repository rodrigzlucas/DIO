const print = (name, level) => {
  console.log(`O Herói de nome ${name} está no nível de ${level}`);
};

const calculateXp = (name, experience) => {
 
  const level = {
    10000: "Imortal",
    9000: "Ascendente",
    8000: "Platina",
    7000: "Ouro",
    5000: "Prata",
    2000: "Bronze",
    1000: "Ferro",
  };

  let heroLevel = "Imortal";

  for (const k of Object.keys(level)) {
    if (experience < k) break;
    heroLevel = level[k];
  }

  print(name, heroLevel);
};

calculateXp("Lucas", 10100);
calculateXp("Lucas", 7500);
