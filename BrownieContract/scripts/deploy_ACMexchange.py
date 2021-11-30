from brownie import ACMExchange, config, network
from scripts.helpful_scripts import (
    get_account,
    get_contract,
)

def deploy_ACMExchange():
    accounts = get_account()

    print(f"On network {network.show_active()}")
    OwnerContract = "0x2E896EDcEeB8e21f9899fa2fD86D3Bdd0a15D93E"
    Token_Address = "0x4eE0fe837C06741f7c1551819d3bd2E660265524"
    NFT_Address = "0xc9c64cd8F0B84eb8239Bf61116f17DB0C78aF2E5"
    allow_TokenId = input("Allow tokenId: ")

    return ACMExchange.deploy(
        Token_Address,
        OwnerContract,
        NFT_Address,
        allow_TokenId,
        {"from": accounts},
        publish_source=config["networks"][network.show_active()].get("verify", False),
    )



def main():
    contract = deploy_ACMExchange()