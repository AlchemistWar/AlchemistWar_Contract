// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
/* 
For transferFrom to succeed, sender must

have more than amount tokens in their balance
allowed TokenSwap to withdraw amount tokens by calling appro */

contract TokenSwap is Ownable{
    IERC20 public token;
    address public owner1;
    uint public amount1;
    IERC20 public token2;
    address public owner2;
    uint public amount2;
    IERC1155 public nftToken;

    uint256[] public allowTokenId;

    constructor(
        address _token,
        address _owner1,
        uint _amount1,
        address _token2,
        address _owner2,
        uint _amount2,
        address _nftToken,
        uint256[] _allowTokenId
    ) 
    {
        token = IERC20(_token);
        owner1 = _owner1;
        amount1 = _amount1;
        token2 = IERC20(_token2);
        owner2 = _owner2;
        amount2 = _amount2;
        nftToken = _nftToken;
        allowTokenId = _allowTokenId;
    }

    function setAllowTokenId(uint256[] arr) public onlyOwner{
        allowTokenId = arr;
    }


    function buyTool(uint256 tokenId, uint256 amount) public {
        IERC1155 acmNFTContract = IERC1155(nftToken);
        IERC20 acmToken = IERC20(token); 
        //balance Token > require
        require(acmToken.balanceOf(msg.sender) > 0);
        //token allowance this address >= amount to pay
        //acmNFTContract Owner address need to have token > 0
        require(tokenId )

        uint256 amountTobuy = msg.value;
        uint256 dexBalance = token.balanceOf(address(this));
        require(amountTobuy > 0, "You need to send some ether");
        require(amountTobuy <= dexBalance, "Not enough tokens in the reserve");
        token.transfer(msg.sender, amountTobuy);

        
        require(msg.sender == owner1 || msg.sender == owner2, "Not authorized");
        require(
            token1.allowance(owner1, address(this)) >= amount1,
            "Token 1 allowance too low"
        );
        require(
            token2.allowance(owner2, address(this)) >= amount2,
            "Token 2 allowance too low"
        );

        _safeTransferFrom(token1, owner1, owner2, amount1);
        _safeTransferFrom(token2, owner2, owner1, amount2);
    }

    function _safeTransferFrom(
        IERC20 token,
        address sender,
        address recipient,
        uint amount
    ) private {
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "Token transfer failed");
    }
}

/* /Attach requestID to roller address after 
    function GachaRandomCaller() public returns (bytes32 requestId) {
        IERC1155 acmNFT = IERC1155(NFTContract_Address);
        require(acmNFT.balanceOf(msg.sender, KeyId) > 0);
        require(acmNFT.isApprovedForAll(msg.sender, address(this)), "contract must approve");
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK to pay fee");
        require(s_results[msg.sender] == 0, "Already rolled");
        acmNFT.safeTransferFrom(msg.sender, Owner_Address, KeyId, 1, "");
        requestId = requestRandomness(keyHash, fee);
        s_rollers[requestId] = msg.sender; // mapping requestId with roller address
        s_results[msg.sender] = ROLL_IN_PROGRESS;
        emit GachaRolled(requestId, msg.sender);
    }


    


    
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        randomResult = randomness;
        s_results[s_rollers[requestId]] = randomness;
        
    }

    function openGacha() public {
        IERC1155 acmNFT = IERC1155(NFTContract_Address);
        require(s_results[msg.sender] != 0, "Roll a randomnumber first");
        require(s_results[msg.sender] != ROLL_IN_PROGRESS, "Calling for random number please wait");

        uint256 index = sample(itemDropChance, s_results[msg.sender]);
        uint256 reward = rewardID[index];
        s_results[msg.sender] = reward;
        acmNFT.safeTransferFrom(Owner_Address, msg.sender, reward, 1, "");
        
        s_results[msg.sender] = 0;
    } */