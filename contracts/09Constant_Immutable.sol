// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/* 
1. 对于 constant 常量, 他的值在编译器确定，而对于 immutable, 它的值在部署时确定。
2. 与常规状态变量相比，常量和不可变量的gas成本要低得多，immutable成本比constant高
3. 不是所有类型的状态变量都支持用 constant 或 immutable 来修饰，当前仅支持 字符串 (仅常量) 和 值类型。
4. 如果状态变量声明为 constant (常量)。在这种情况下，只能使用那些在"编译时有确定值的表达式"来给它们赋值
5. 声明为不可变量(immutable)的变量,可以在合约的构造函数中或声明时为不可变的变量分配任意值。 immutable只能赋值一次，并且在赋值之后才可以读取
6. immutable可以在声明时赋值，不过只有在合约的构造函数执行时才被视为视为初始化。 这意味着，你不能用一个依赖于不可变量的值在行内初始化另一个不可变量。 不过，你可以在合约的构造函数中这样做。

综上所述:
1. constant在声明时必须初始化, 并且初始化的值必须是值类型
    - 因为他是在编译阶段确定的, 所以他的初始值可以是编译阶段明确的值或者表达式, 
    - 不能是函数的返回值(编译不会调用函数), 以及部署后才有的变量(msg.xx, tx.xx, block.xx, address(this)等)
2. immutable可以先声明后赋值, 但是只能赋值一次, 值必须是"除了string, bytes外的值类型", 可以是address, uint等
    - 他是在部署阶段确定的, 所以可以赋值值, 表达式, 函数返回值, 以及一些全局变量
    - immutable必须并且只能在声明时初始化, 或者在构造函数中初始化。不初始化会报错
*/

contract ConstantAndImmutable {
    // 可以是1, 1+1, 不能是genValue(), msg.xx, tx.xx, block.xx, address(this)等
    uint256 public constant value1 = 1;

    // constant变量必须在声明的时候初始化，之后不能改变
    uint256 constant CONSTANT_NUM = 10;
    string constant CONSTANT_STRING = "0xAA";
    bytes constant CONSTANT_BYTES = "WTF";
    address constant CONSTANT_ADDRESS =
        0x0000000000000000000000000000000000000000;

    function genValue() public pure returns (uint256) {
        return 123;
    }

    // immutable变量可以在constructor里初始化，之后不能改变
    uint256 public immutable IMMUTABLE_NUM = 9999999999;
    address public immutable IMMUTABLE_ADDRESS;
    uint256 public immutable IMMUTABLE_BLOCK;
    uint256 public immutable IMMUTABLE_TEST;

    // 利用constructor初始化immutable变量，因此可以利用
    constructor() {
        IMMUTABLE_ADDRESS = address(this);
        IMMUTABLE_BLOCK = block.number;
        IMMUTABLE_TEST = test();
    }

    function test() public pure returns (uint256) {
        uint256 what = 9;
        return (what);
    }
}
