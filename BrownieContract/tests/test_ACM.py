import time
import pytest
from brownie import Gacha, ACMExchange, AlchemistNFT,AlchemistToken, convert, network
from scripts.helpful_scripts import (
    get_account,
    get_contract,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
)



def test_returns_random_number_testnet(
    get_keyhash,
    chainlink_fee,
):
    # Arrange
    if network.show_active() not in ["kovan", "rinkeby", "ropsten"]:
        pytest.skip("Only for testnet testing")
    vrf_consumer = VRFConsumer.deploy(
        get_keyhash,
        get_contract("vrf_coordinator").address,
        get_contract("link_token").address,
        chainlink_fee,
        {"from": get_account()},
    )
    get_contract("link_token").transfer(
        vrf_consumer.address, chainlink_fee * 3, {"from": get_account()}
    )
    # Act
    transaction_receipt = vrf_consumer.getRandomNumber({"from": get_account()})
    assert isinstance(transaction_receipt.txid, str)
    transaction_receipt.wait(1)
    time.sleep(90)
    # Assert
    assert vrf_consumer.randomResult() > 0
    assert isinstance(vrf_consumer.randomResult(), int)


