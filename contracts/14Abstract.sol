// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/*
// 抽象合约和接口既不能编译也不能部署

抽象合约(至少有一个未实现的函数的合约, 可以有实现的函数): 
- 一个智能合约里至少有一个未实现的函数，即某个函数缺少主体{}中的内容包括这个{}括号
- 则必须将该合约标为abstract，不然编译会报错；
- 未实现的函数需要加virtual，以便子合约重写。
- 拿我们之前的插入排序合约为例，如果我们还没想好具体怎么实现插入排序函数，那么可以把合约标为abstract，之后让别人补写上。


接口:
接口类似于抽象合约，但它不实现任何功能。接口的规则：
1. 不能包含状态变量
2. 不能包含构造函数
3. 不能继承除接口外的其他合约/只能继承接口
4. 所有函数都必须是external且不能有函数体
5. 继承接口的合约必须实现接口定义的所有功能

虽然接口不实现任何功能，但它非常重要。接口是智能合约的骨架，定义了合约的功能以及如何触发它们：如果智能合约实现了某种接口（比如ERC20或ERC721），其他Dapps和智能合约就知道如何与它交互。因为接口提供了两个重要的信息：

合约里每个函数的bytes4选择器，以及基于它们的函数签名函数名(每个参数类型）。

另外，接口与合约ABI（Application Binary Interface）等价，可以相互转换：编译接口可以得到合约的ABI，利用abi-to-sol工具也可以将ABI json文件转换为接口sol文件。

什么时候使用接口？
如果我们知道一个合约实现了IERC721接口，我们就知道了IERC721接口部分的api, 知道如何传递参数和调用，就可以与它交互。

*/
abstract contract InsertionSort {
    function insertionSort(uint256[] memory a)
        public
        pure
        virtual
        returns (uint256[] memory);

    function f() public {}
}

// interface IERC721 is IERC165
interface IERC721 {
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );
    event Approval(
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId
    );
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );

    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    function approve(address to, uint256 tokenId) external;

    function getApproved(uint256 tokenId)
        external
        view
        returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(address owner, address operator)
        external
        view
        returns (bool);

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;
}

interface IA {
    function f() external pure;
}

contract A is IA {
    function f() external pure{}
}
