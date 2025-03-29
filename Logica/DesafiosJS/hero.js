class Hero {
  name;
  age;
  type;
  atacks = {
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

  atack() {
    console.log(
      `o ${this.type} atacou usando ${this.atacks[this.type.toLowerCase()]}`
    );
  }
}

new Hero("Lucas", 16, "Warrior").atack();
