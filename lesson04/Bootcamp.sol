// SPDX-License-Identifier: None

pragma solidity 0.8.17;

contract BootcampContract {
    uint256 number;
    address deployerAddress;
    address deadAddress = 0x000000000000000000000000000000000000dEaD;

    constructor() {
        deployerAddress = msg.sender;
    }

    function deployer() external view returns (address) {
        if (deployerAddress == msg.sender) {
            return deadAddress;
        }
        return deployerAddress;
    }

    function store(uint256 num) public {
        number = num;
    }

    function retrieve() public view returns (uint256) {
        return number;
    }
}
