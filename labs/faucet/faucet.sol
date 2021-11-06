/**
 * @file faucet.sol
 * @date 17th Apr 2019
 */
 
pragma solidity 0.6.4;

contract faucet {
    
 	address public me;
	constructor() public payable {
		me = msg.sender;
	}
	
    // Accept any incoming amount
    receive() external payable {}
 


	struct requester {
        address requesteraddress;
        uint amount;
    }
    
    requester[] public requesters;
   
	event sent(uint _amountsent);
	event received();



    function send(address payable _requester, uint _request)
        public
        payable
    {
        uint amountsent = 0;
        _request = _request * 1e18;
        
        if (address(this).balance > _request){
            amountsent = _request/1e18;
            _requester.transfer(_request);   
        }
        else{
            amountsent = (address(this).balance)/1e18;
            _requester.transfer(address(this).balance);
        }
        
        requester memory r;
        r.requesteraddress = _requester;
        r.amount = amountsent;
        requesters.push(r);
        emit sent(amountsent);
    }
}
