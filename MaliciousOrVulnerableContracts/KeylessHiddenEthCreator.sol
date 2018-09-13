pragma solidity ^0.4.19;

contract KeylessHiddenEthCreator { 
    uint public currentContractNonce = 1; // keep track of this contracts nonce publicly (it's also found in the contracts state)
    // determine future addresses which can hide ether. 
    function futureAddresses(uint8 nonce) public view returns (address) {
        if(nonce == 0) {
            return address(keccak256(0xd6, 0x94, this, 0x80));
        }
        return address(keccak256(0xd6, 0x94, this, nonce));
    // need to implement rlp encoding properly for a full range of nonces
    }
    
    // increment the contract nonce or retrieve ether from a hidden/key-less account
    // provided the nonce is correct
    function retrieveHiddenEther(address beneficiary) public returns (address) {
    currentContractNonce +=1;
       return new RecoverContract(beneficiary);
    }
    
    function () payable {} // Allow ether transfers (helps for playing in remix)
}
contract RecoverContract { 
    constructor(address beneficiary) {
        selfdestruct(beneficiary); // don't deploy code. Return the ether stored here to the beneficiary. 
    }
 }
