// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/BadgerCoin.sol";

contract TestBadgerCoin is Test {
    BadgerCoin badgerCoin;

    function setUp() public {
        badgerCoin = new BadgerCoin();
    }

    function testMintShouldRevertWhenPause() public {
        badgerCoin.pause();
        vm.expectRevert();
        badgerCoin.mint(address(1), 100_000);
    }

    function testTransferShouldRevertWhenPause() public {
        badgerCoin.pause();
        vm.expectRevert();
        badgerCoin.transfer(address(1), 100);
    }

    function testTransferAfterUnPause() public {
        badgerCoin.pause();
        badgerCoin.unpause();
        badgerCoin.transfer(address(1), 1000);
        assertEq(
            badgerCoin.balanceOf(address(1)),
            1000,
            "balance is not equal to 1000"
        );
    }

    function testRevertMintWhen_NotOwner() public {
        vm.prank(address(0));
        vm.expectRevert();
        badgerCoin.mint(address(0), 1);
    }

    function testTransferFrom() public {
        badgerCoin.mint(address(123), 1000);
        vm.prank(address(123));
        badgerCoin.approve(address(234), 500);
        vm.prank(address(234));
        badgerCoin.transferFrom(address(123), address(1), 250);
        assertEq(badgerCoin.balanceOf(address(1)), 250);
    }

    function testRevertTransferFrom_whenPaused() public {
        badgerCoin.mint(address(123), 1000);
        vm.prank(address(123));
        badgerCoin.approve(address(234), 500);
        badgerCoin.pause();
        vm.prank(address(234));
        vm.expectRevert();
        badgerCoin.transferFrom(address(123), address(1), 250);
    }
}
