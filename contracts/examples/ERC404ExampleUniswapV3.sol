//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {ERC404} from "../ERC404.sol";
import {ERC404UniswapV3Exempt} from "../extensions/ERC404UniswapV3Exempt.sol";

contract ERC404ExampleUniswapV3 is Ownable, ERC404, ERC404UniswapV3Exempt {
  string public dataURI;
  string public baseTokenURI;

  constructor(
    string memory name_,
    string memory symbol_,
    string memory dataURI_,
    string memory baseTokenURI_,
    uint8 decimals_,
    uint256 maxTotalSupplyERC721_,
    address initialOwner_,
    address initialMintRecipient_,
    address uniswapSwapRouter_,
    address uniswapV3NonfungiblePositionManager_
  )
    ERC404(name_, symbol_, decimals_)
    Ownable(initialOwner_)
    ERC404UniswapV3Exempt(
      uniswapSwapRouter_,
      uniswapV3NonfungiblePositionManager_
    )
  {
    dataURI = dataURI_;
    baseTokenURI = baseTokenURI_;
    // Do not mint the ERC721s to the initial owner, as it's a waste of gas.
    _setERC721TransferExempt(initialMintRecipient_, true);
    _mintERC20(initialMintRecipient_, maxTotalSupplyERC721_ * units);
  }

  function tokenURI(uint256 id) public view override returns (string memory) {
    if (bytes(baseTokenURI).length > 0) {
      return string.concat(baseTokenURI, Strings.toString(id));
    } else {
      uint8 seed = uint8(bytes1(keccak256(abi.encodePacked(id))));
      string memory image;
      string memory color;

      if (seed <= 100) {
        image = "1.gif";
        color = "Green";
      } else if (seed <= 160) {
        image = "2.gif";
        color = "Blue";
      } else if (seed <= 210) {
        image = "3.gif";
        color = "Purple";
      } else if (seed <= 240) {
        image = "4.gif";
        color = "Orange";
      } else if (seed <= 255) {
        image = "5.gif";
        color = "Red";
      }

      string memory jsonPreImage = string.concat(
        string.concat(
          string.concat('{"name": "Pandora #', Strings.toString(id)),
          '","description":"A collection of 10,000 Replicants enabled by ERC404, an experimental token standard.","external_url":"https://pandora.build","image":"'
        ),
        string.concat(dataURI, image)
      );
      string memory jsonPostImage = string.concat(
        '","attributes":[{"trait_type":"Color","value":"',
        color
      );
      string memory jsonPostTraits = '"}]}';

      return
        string.concat(
        "data:application/json;utf8,",
        string.concat(
          string.concat(jsonPreImage, jsonPostImage),
          jsonPostTraits
        )
      );
    }
  }

  function setERC721TransferExempt(
    address account_,
    bool value_
  ) external onlyOwner {
    _setERC721TransferExempt(account_, value_);
  }
}
