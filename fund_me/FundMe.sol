//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe {
	address public owner;
	address[] public funders;
	mapping(address => uint256) public addressToAmountFunded;

	constructor() public {
		owner = msg.sender;
	}

	function fund() public payable {
		uint256 minimumUSD = 50 * 10 ** 18; // 50 x 10^18 = 50 USD en wei
	    require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more ETH!");
		// KEYWORDS - msg.sender - msg.value
		addressToAmountFunded[msg.sender] += msg.value;
		funders.push(msg.sender);
	}

	function getVersion() public view returns(uint256) {
		AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
		return priceFeed.version();
	}
	
	function getPrice() public view returns(uint256) {
		AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
		// 'destructuring'
		(, int256 answer,,,) = priceFeed.latestRoundData();
    	
        return uint256(answer * 10_000_000_000);//answer is in gwei (8 decimals) so we add 10 decimals to match wei
	}
	
	function getConversionRate(uint256 ethAmount) public view returns (uint256) {
		uint256 ethPrice = getPrice();
		return (ethPrice * ethAmount) / 1_000_000_000_000_000_000; //convert back from wei
	}

	modifier onlyOwner{ 
		require(msg.sender == owner, "You aren't authorized to withdraw ETH!");
		_; //run the rest of the code
	}

	function withdraw() public onlyOwner payable {
		// this => contract
		//require(msg.sender == owner, "You aren't authorized to withdraw ETH!");
		msg.sender.transfer(address(this).balance);
		//mappings can't be traversed, this is the workaround
		for(uint256 i = 0; i < funders.length; i++){
			address funder = funders[i];
			addressToAmountFunded[funder] = 0;
		}
		//reset the funders array
		funders = new address[](0);
	}
}