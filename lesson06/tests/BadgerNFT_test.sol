// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol";

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "../BadgerNFT.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {
    BadgerNFT badgerNFT;
    /// Define variable for addresses being used in the test
    address acc0;
    address acc1;

    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    function beforeAll() public {
        // <instantiate contract>
        badgerNFT = new BadgerNFT();
        acc0 = TestsAccounts.getAccount(0);
        acc1 = TestsAccounts.getAccount(1);
    }

    /// #sender: account-0
    function checkMintingAcc0() public {
        badgerNFT.safeMint(acc0);
        Assert.ok(
            acc0 == badgerNFT.ownerOf(0),
            "owner of NFT index 0 not the same as the account-0"
        );
    }

    /// #sender: account-1
    function checkMintingAcc1() public {
        badgerNFT.safeMint(acc1);
        Assert.ok(
            acc1 == badgerNFT.ownerOf(1),
            "owner of NFT index 1 not the same as the account-1"
        );
    }

    /// #sender: account-1
    function checkMintingAcc1_2() public {
        badgerNFT.safeMint(acc1);
        Assert.ok(
            acc1 == badgerNFT.ownerOf(2),
            "owner of NFT index 2 not the same as the account-1"
        );
    }

    /// #sender: account-1
    function sendNFTAcc1ToAcc0() public {
        badgerNFT.approve(address(this), 1); /// todo: this thing still throw error, searching for solution
        badgerNFT.safeTransferFrom(msg.sender, acc0, 1);
        Assert.ok(
            acc0 == badgerNFT.ownerOf(1),
            "owner of NFT index 1 not the same as the account-0"
        );
    }
}
