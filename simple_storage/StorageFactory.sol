//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//contract import from another file
import "./SimpleStorage.sol";

// is === extends === inherit
contract StorageFactory is SimpleStorage {

	SimpleStorage[] public simpleStorageArray;

	function createSimpleStorageContract() public {
		SimpleStorage simpleStorage = new SimpleStorage();
		simpleStorageArray.push(simpleStorage);
	}

	function sf_store(uint256 _index, uint256 _number) public {
		//To interact with another contract, you need: 
		// > Address
		// > ABI (Application Binary Interface)

		//SimpleStorage _storage = SimpleStorage(address(simpleStorageArray[_index])); // 'getter'
		//_storage.store(_number);
		return SimpleStorage(address(simpleStorageArray[_index])).store(_number);
	}
	
	function sf_get(uint256 _index) public view returns(uint256) {
	    //SimpleStorage _storage = SimpleStorage(address(simpleStorageArray[_index])); // 'getter'
	    //return _storage.retrieve();
	    return SimpleStorage(address(simpleStorageArray[_index])).retrieve();
	}
}