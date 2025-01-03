// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19 <0.9.0;

// Standard test libs
import "forge-std/Test.sol";
import "forge-std/Vm.sol";

// contract under test
import { DogCoin } from "../src/DogCoin.sol";

contract DogCoinTest is Test {
    // variable for contract instance
    DogCoin private dogCoin;

    function setUp() public {
        // instantiate new contract instance
        dogCoin = new DogCoin();
    }

    function test_Log() public {
        emit log("here");
        emit log_address(address(this));
        emit log_address(HEVM_ADDRESS);
    }

    function test_Mint() public {
        dogCoin._mint(1);
        assertTrue(dogCoin.getTotalSupply() % 1000 == 0);
    }

    function test_RevertWhen_Caller_notOwner() public {
        vm.expectRevert();
        vm.prank(address(0));
        dogCoin._mint(1);
    }

    // function test_CorrectEventEmit_WhenTransfer() public {
    //     vm.expectEmit(true, true, false, true);
    //     dogCoin.transfer(address(11), 1000);
    // }
}
