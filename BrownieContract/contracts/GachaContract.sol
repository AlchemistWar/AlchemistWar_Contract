// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract Gacha is VRFConsumerBase, Ownable {

    bytes32 internal keyHash;
    uint256 internal fee;

    //Gacha variable
    uint256 public KeyId;
    uint256[] public itemDropChance; //Drop rate of the item
    uint256[] public rewardID; //reward ID of ERC1155 NFT Token

    address public NFTContract_Address;
    address public Owner_Address;

    mapping(bytes32 => address) private s_rollers;
    mapping(address => uint256) private s_results;
    
    mapping(address => uint256)[] public NumberOfItem;

    
    
    uint256 public randomResult;
    uint256 private constant ROLL_IN_PROGRESS = 10000000000;

    event GachaRolled(bytes32 indexed requestId, address indexed roller);
    event GachaResult(bytes32 indexed requestId, uint256 indexed result);
  
     
    constructor(bytes32 _keyhash, address _vrfCoordinator, address _linkToken, uint256 _fee, uint256[] memory arrayOfItemDropChance, uint256[] memory arr_ID, address OwnerContract, address NFT_address, uint256 _keyId) 
        VRFConsumerBase(
            _vrfCoordinator, // VRF Coordinator
            _linkToken  // LINK Token
        ) 
    {
        keyHash = _keyhash;
        // fee = 0.1 * 10 ** 18; // 0.1 LINK
        fee = _fee;
        itemDropChance = arrayOfItemDropChance; //Drop rate of the item
        rewardID = arr_ID;
        NFTContract_Address = NFT_address;
        Owner_Address = OwnerContract;
        KeyId = _keyId;
    }

    




    //Use this function to set Gacha item properties, this require 2 input array of itemDropChance ex. [70,20,10] and arr_ID is input parameter to set the array ID of reward ACM NFT token 
    function setGachaItemProperties(uint256[] memory arrayOfItemDropChance, uint256[] memory arr_ID, address OwnerContract, address NFT_address, uint256 _keyId) public onlyOwner{
        itemDropChance = arrayOfItemDropChance; //Drop rate of the item
        rewardID = arr_ID;
        NFTContract_Address = NFT_address;
        Owner_Address = OwnerContract;
        KeyId = _keyId;
    }

    
    //Sum of array to calculate item_drop_rate
    function calcSum(uint256[] memory arr) public returns (uint256 sum) {
        sum = 0;
        for(uint256 i=0; i<arr.length; i++){
            sum = sum + arr[i];
        }
        return sum;
    }

   //This function use to check if item are pick or not if not then go to next index

    function sample(uint256[] memory arr, uint256 randomness) public returns (uint256 index) {
        uint256 s = 0; //use sum to find the outcome result
        //check result from player address
        uint256 random = randomness % calcSum(arr);

        
        for(uint256 i = 0; i < arr.length; i++) {
            
            s += arr[i];

            if(s >= random){
                break;
            }

            index++;
        } 
    }




    //Attach requestID to roller address after 
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


    

    /**
     * Callback function used by VRF Coordinator
     */

    
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
    }

}