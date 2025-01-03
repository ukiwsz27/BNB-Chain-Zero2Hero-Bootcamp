const { expect } = require("chai");
const { ethers } = require("hardhat");
// const EventEmitter = require("events").EventEmitter;

describe("DogCoin", async () => {
  // Initialize variable
  let DogCoin, dogCoin, owner, addr1, addr2;
  before(async () => {
    DogCoin = await ethers.getContractFactory("DogCoin");
    dogCoin = await DogCoin.deploy();
    // await dogCoin.deployed();
    // Get accounts and assign to pre-defined variables
    [owner, addr1, addr2, _] = await ethers.getSigners();
  });
  describe("Testing", () => {
    it("Using _mint function makes the total supply increased in step of 1000", async () => {
      await dogCoin._mint(1);
      expect((await dogCoin.getTotalSupply()) % 1000).to.equal(0);
    });
    it("Using different address other than owner should throw error", async () => {
      expect(await dogCoin.connect(addr1)._mint(1));
    });
    it("Should emit correct event", async () => {
      // emitter = new EventEmitter();
      let p = await dogCoin.transfer(addr1.address, 100);
      expect(p).to.emit("TokenTransferred");
    });
  });
});
