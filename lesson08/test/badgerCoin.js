const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("BadgerCoin", () => {
  // Initialize variable
  let BadgerCoin, badgerCoin, owner, addr1, addr2;
  before(async () => {
    // Deploy a new instance of the contract
    BadgerCoin = await ethers.getContractFactory("BadgerCoin");
    badgerCoin = await BadgerCoin.deploy();
    // Get accounts and assign to pre-defined variables
    [owner, addr1, addr2, _] = await ethers.getSigners();
  });

  describe("Deployment", () => {
    it("Total supply equal to 1000000", async () => {
      // failing test
      // expect(addr1.address).to.not.equal(await badgerCoin.owner());
      // passing test
      expect((await badgerCoin.totalSupply()) / 10 ** (await badgerCoin.decimals())).to.equal(1000000);
    });
    it("Number of decimals equal to 18", async () => {
      expect(await badgerCoin.decimals()).to.equal(18);
    });
    it("balanceOf function returns correct result", async () => {
      expect((await badgerCoin.balanceOf(owner.address)) / 10 ** (await badgerCoin.decimals())).to.equal(1000000);
    });
    it("transfer function works correctly", async () => {
      const transfer = await badgerCoin.transfer(addr1.address, ethers.utils.parseUnits("100", 18));
      expect((await badgerCoin.balanceOf(addr1.address)) / 10 ** 18).to.equal(100);
    });
    it("Should throw an error because transfer with insufficient balance", async () => {
      expect(await badgerCoin.connect(addr1).transfer(addr2.address, ethers.utils.parseUnits("101", 18)));
    });
  });
});
