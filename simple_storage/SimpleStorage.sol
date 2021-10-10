//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleStorage {
	/* DATA TYPES
	uint256 favouriteNumber = 5; // numeros absolutos
	bool isEth = true;
	string message = 'todorojo';
	int anotherNumber = -1; 
	address myAddress = 0xE636d47e00cAeEfC97d0e6E915bf8e26DBD183F0;
	*/
	
	uint256 number; //will initialize to 0

	//'Objects'
	struct People{
		uint256 number;
		address _address;
	}
	//'Object' initialization
	People public person = People({
		number: 123, 
		_address: 0xE636d47e00cAeEfC97d0e6E915bf8e26DBD183F0
	});

	mapping(address => uint256) public _addressToNumber; //'interfaz' del mapeo
	//Array dinamico de objetos (se puede definir un tamaño fijo)
	People[] public people;

	function store(uint256 _number) public {
		number = _number;
	}
	
	function retrieve() public view returns(uint256) {
		return number;
	}

	function doubleNumber(uint256 _number) public pure returns(uint256) {
		return _number * 2;
	}

	function addNumber(uint256 _number, address __address) public {
		people.push(People(_number, __address));
		_addressToNumber[__address] = _number; //definimos el mapeo al crear el registro
	}
}
