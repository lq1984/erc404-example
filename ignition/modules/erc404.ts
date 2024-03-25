import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const ERC404ExampleUniswapV3 = buildModule("ERC404ExampleUniswapV3", (m) => {
    const name = m.getParameter("name");
    const symbol = m.getParameter("symbol");
    const dataURI = m.getParameter("dataURI");
    const baseTokenURI = m.getParameter("baseTokenURI");
    const decimals = m.getParameter("decimals");
    const maxTotalSupplyERC721 = m.getParameter("maxTotalSupplyERC721");
    const initialOwner = m.getParameter("initialOwner");
    const initialMintRecipient = m.getParameter("initialMintRecipient");
    const uniswapSwapRouter = m.getParameter("uniswapSwapRouter");
    const uniswapV3NonfungiblePositionManager = m.getParameter("uniswapV3NonfungiblePositionManager");

    const erc404 = m.contract("ERC404ExampleUniswapV3",
        [
            name ,
            symbol,
            dataURI,
            baseTokenURI,
            decimals,
            maxTotalSupplyERC721,
            initialOwner,
            initialMintRecipient,
            uniswapSwapRouter,
            uniswapV3NonfungiblePositionManager,
        ]
    );

    return { erc404 };
});

export default ERC404ExampleUniswapV3