class Hero {
  name;
  age;
  type;
  attacks = {
    warrior: "Sword",
    wizard: "Magic",
    monk: "Martial Arts",
    ninja: "Shuriken",
  };

  constructor(name, age, type) {
    this.name = name;
    this.age = age;
    this.type = type;
  }

  attack() {
    console.log(
      `o ${this.type} atacou usando ${this.attacks[this.type.toLowerCase()]}`
    );
  }
}

new Hero("Lucas", 16, "Warrior").attack();
