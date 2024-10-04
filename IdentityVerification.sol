// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedIdentityVerification {
    struct User {
        string name;
        string email;
        bool isVerified;
    }

    mapping(address => User) public users;

    event UserRegistered(address indexed userAddress, string name, string email);
    event UserVerified(address indexed userAddress);
    event UserUnverified(address indexed userAddress);

    function registerUser(string memory _name, string memory _email) public {
        require(bytes(users[msg.sender].name).length == 0, "User already registered");

        users[msg.sender] = User({
            name: _name,
            email: _email,
            isVerified: false
        });

        emit UserRegistered(msg.sender, _name, _email);
    }

    function verifyUser(address _userAddress) public {
        require(bytes(users[_userAddress].name).length != 0, "User not registered");
        require(!users[_userAddress].isVerified, "User already verified");

        users[_userAddress].isVerified = true;
        emit UserVerified(_userAddress);
    }

    function unverifyUser(address _userAddress) public {
        require(users[_userAddress].isVerified, "User not verified");

        users[_userAddress].isVerified = false;
        emit UserUnverified(_userAddress);
    }

    function getUserInfo(address _userAddress) public view returns (string memory, string memory, bool) {
        User memory user = users[_userAddress];
        return (user.name, user.email, user.isVerified);
    }
}
