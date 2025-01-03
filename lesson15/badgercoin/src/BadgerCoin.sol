// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/security/Pausable.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract BadgerCoin is ERC20, Pausable, Ownable {
    constructor() ERC20("BadgerCoin", "BADGER") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function mint(address _addr, uint _amount) public onlyOwner {
        _mint(_addr, _amount);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override whenNotPaused {
        super._beforeTokenTransfer(from, to, amount);
    }
}
