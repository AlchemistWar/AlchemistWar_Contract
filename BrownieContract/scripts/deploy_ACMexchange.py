from brownie import Gacha, config, network
from scripts.helpful_scripts import (
    get_account,
    get_contract,
    fund_with_link,
)

def deploy_gacha():
    accounts = get_account()

    print(f"On network {network.show_active()}")
    keyhash = config["networks"][network.show_active()]["keyhash"]
    fee = config["networks"][network.show_active()]["fee"]
    vrf_coordinator = get_contract("vrf_coordinator")
    link_token = get_contract("link_token")
    Arr_chance = [10,20,50]
    Arr_ID = [1,2,3]
    OwnerContract = "0x2E896EDcEeB8e21f9899fa2fD86D3Bdd0a15D93E"
    NFT_Address = "0xc9c64cd8F0B84eb8239Bf61116f17DB0C78aF2E5"
    KeyID = input("KEYID")

    return Gacha.deploy(
        keyhash,
        vrf_coordinator,
        link_token,
        fee,
        Arr_chance,
        Arr_ID,
        OwnerContract,
        NFT_Address,
        KeyID,
        {"from": accounts},
        publish_source=config["networks"][network.show_active()].get("verify", False),
    )

def fund_gacha(contract):
    gacha_contract = contract
    tx = fund_with_link(
        gacha_contract.address, amount=config["networks"][network.show_active()]["fee"]
    )
    tx.wait(1)

    print("done request")


def main():
    contract = deploy_gacha()
    fund_gacha(contract)