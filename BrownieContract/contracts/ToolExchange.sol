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

contract ACMTokenSwap is Ownable{
    IERC20 public ACMtoken;
    IERC1155 public ACMnftToken;
    address public owner;
    uint public amount;
    

    mapping(uint256 => bool) public allowTokenId;
    mapping(uint256 => uint256) public tokenPrice; 

    constructor(
        address _token,
        address _owner,
        uint _amount,
        address _nftToken,
        uint256[] _allowTokenId,
        uint256[] _tokenPrice
    ) 
    {
        ACMtoken = IERC20(_token);
        owner = _owner;
        amount = _amount;
        ACMnftToken = IERC1155(_nftToken);
        for(i=0;i<_allowTokenId.length;i++){
            allowTokenId[_allowTokenId[i]] = true;
        }
    }

    function setAllowTokenId(uint256 _tokenId, bool _bool) public onlyOwner{
        allowTokenId[_tokenId] = _bool;
    }
    function setTokenPrice(uint256[] _tokenId, uint256 price) public onlyOwner{
        tokenPrice[_tokenId] = price;
    }


    function buyTool(uint256 tokenId, uint256 amount) public {
        require(ACMtoken.balanceOf(msg.sender) > 0);
        require(allowTokenId[tokenId] == true, "This tokenId were not allow to purchase");
        require(tokenPrice[tokenId] != 0, "Price of this token have not been set yet");
        require(ACMToken.allowance(owner1, address(this)) >= amount, "Please allow the contract to spend your token");
        require(ACMnftToken.isApprovedForAll(msg.sender, address(this)), "contract must approve");

        //pay with ERC20 token first
        //Transfer NFTs token to user
        safeTransferFrom(ACMToken, msg.sender, owner, amount * tokenPrice[tokenId]);
        ACMnftToken.safeTransferFrom(owner, msg.sender, tokenId, amount, "");
    }
}