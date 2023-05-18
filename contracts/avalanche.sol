// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract DegenToken is ERC20("Degen", "DGN"), Ownable, ERC20Burnable {
    event consoleLog(string output);

    function getBalance() external view returns (uint) {
        return this.balanceOf(msg.sender);
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    function mintDGN(address ownerAddress, uint value) public onlyOwner {
        _mint(ownerAddress, value);
    }

    function burnDGN(uint value) public {
        require(
            balanceOf(msg.sender) >= value,
            "Your balance is insufficient for this transaction."
        );
        _burn(msg.sender, value);
    }

    function transferDGN(address receiver, uint value) external {
        require(
            balanceOf(msg.sender) >= value,
            "Your balance is insufficient for this transaction."
        );
        approve(msg.sender, value);
        transferFrom(msg.sender, receiver, value);
    }

    function buyItems(uint codeNumber) public payable {
        address _owner = 0x1A04139836b1eDc63714E731BDd5C2eb2e20543D;
        if (codeNumber == 100) {
            //Tokens
            require(
                balanceOf(msg.sender) >= 20,
                "Your balance is insufficient for this transaction. (20 DGN)"
            );
            approve(msg.sender, 20);
            transferFrom(msg.sender, _owner, 20);
            emit consoleLog("You have received a Degen Hat!");
        } else if (codeNumber == 200) {
            //NFT Prize
            require(
                balanceOf(msg.sender) >= 30,
                "Your balance is insufficient for this transaction. (30 DGN)"
            );
            approve(msg.sender, 30);
            transferFrom(msg.sender, _owner, 30);
            emit consoleLog("You have received your own custon Degen NFT!");
        } else if (codeNumber == 300) {
            //Mystery
            require(
                balanceOf(msg.sender) >= 100,
                "Your balance is insufficient for this transaction. (100 DGN)"
            );
            approve(msg.sender, 100);
            transferFrom(msg.sender, _owner, 100);
            emit consoleLog("You have received some SWAG. Check your inbox.");
        } else {
            emit consoleLog("Invalid Code Number.");
        }
    }
}
