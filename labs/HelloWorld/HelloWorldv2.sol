// SPDX-License-Identifier: CC-BY-SA-4.0

pragma solidity >=0.5.8 <0.7.0;

contract HelloWorld {
   string public message;
   string public name;

   constructor(string memory initMessage) public {
       message = initMessage;
   }

   function update(string memory newMessage) public {
       message = newMessage;
   }

   function setname(string memory namemessage) public {
       name = namemessage;
   }

   function getMessage() public view returns (string memory a, string memory b){
       return (name, message);
   }
}
