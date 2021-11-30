from brownie import ACMExchange, config, network
from scripts.helpful_scripts import (
    get_account,
    get_contract,
    fund_with_link,
)

def deploy_gacha():
    accounts = get_account()

    print(f"On network {network.show_active()}")
    keyhash = config["networks"][network.show_active()]["keyhash"]
    OwnerContract = "0x2E896EDcEeB8e21f9899fa2fD86D3Bdd0a15D93E"
    Token_Address = "0x4eE0fe837C06741f7c1551819d3bd2E660265524"
    NFT_Address = "0xc9c64cd8F0B84eb8239Bf61116f17DB0C78aF2E5"
    KeyID = input("KEYID")
constructor(
        address _token,
        address _owner,
        uint _amount,
        address _nftToken,
        uint256[] _allowTokenId,
        uint256[] _tokenPrice
    ) 
    return ACMExchange.deploy(
        Token_Address,
        OwnerContract,
        KeyID,
        {"from": accounts},
        publish_source=config["networks"][network.show_active()].get("verify", False),
    )



def main():
    contract = deploy_gacha()