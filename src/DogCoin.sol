// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract DogCoin {
    uint256 totalSupply;
    mapping(address => uint256) public balances;

    struct Payment {
        uint256 _amount;
        address _recipient;
    }

    mapping(address => Payment[]) public payments;

    event SupplyChanged(uint256);
    event TokenTransferred(address indexed to, uint256);

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function _mint(uint256 _step) public onlyOwner {
        totalSupply += _step * 1000;
        emit SupplyChanged(totalSupply);
    }

    address public owner;

    constructor() {
        owner = msg.sender;
        totalSupply = 2_000_000;
        balances[msg.sender] = totalSupply;
    }

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    // we dont need sender address we check it in the next line.
    // if we set the sender address as parameter then everyone can transfer anyone token balances.
    function transfer(address _recipient, uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "not enough balance!");
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        payments[msg.sender].push(Payment(_amount, _recipient));
        emit TokenTransferred(_recipient, _amount);
    }

    function getPayments(address _addr) public view returns (Payment[] memory) {
        return payments[_addr];
    }
}
