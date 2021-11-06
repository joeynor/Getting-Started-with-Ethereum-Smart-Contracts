pragma solidity >=0.5.8 <0.7.0;

contract Certificate {
    
   string public certID;
   string public issuer;
   string public receivername;
   string public issueddate;
   string public valid;

   constructor(string memory cid, string memory issuername) public {
       certID = cid;
       issuer= issuername;
   }
   
   function confercert(string memory rcname, string memory idate ) public {
       receivername = rcname;
       issueddate = idate;
       valid = "valid";
   }

   function revoke() public {
       valid = "invalid";
   }
}
