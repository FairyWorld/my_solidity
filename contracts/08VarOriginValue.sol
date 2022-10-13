// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/*
值类型初始值
boolean: false
string: ""
int: 0
uint: 0
enum: 枚举中的第一个元素
address: 0x0000000000000000000000000000000000000000 (或 address(0))
function
internal: 空白方程
external: 空白方程
bytes1: 一个字节, 8位, 2个16进制位, 初始值: 0x00。其他字节类型依次类推.


引用类型初始值
映射mapping: 所有元素都为其默认值的mapping
结构体struct: 所有成员设为其默认值的结构体
数组array：
    动态数组: []
    静态数组（定长）: 所有成员设为其默认值的静态数组


delete操作符：delete a会让变量a的值变为初始值。
*/
contract VarOriginValue {
    bool public _bool; // false
    string public _string; // ""
    int256 public _int; // 0
    uint256 public _uint; // 0
    address public _address; // 0x0000000000000000000000000000000000000000

    enum ActionSet {
        Buy,
        Hold,
        Sell
    }
    ActionSet public _enum; // 第一个元素 0

    function fi() internal {} // internal空白方程

    function fe() external {} // external空白方程

    // Reference Types
    uint256[8] public _staticArray; // 所有成员设为其默认值的静态数组[0,0,0,0,0,0,0,0]
    uint256[] public _dynamicArray; // `[]`
    mapping(uint256 => address) public _mapping; // 所有元素都为其默认值的mapping
    // 所有成员设为其默认值的结构体 0, 0
    struct Student {
        uint256 id;
        uint256 score;
    }
    Student public student;

    // delete操作符
    bool public _bool2 = true;

    function d() external {
        delete _bool2; // delete 会让_bool2变为默认值，false
    }
}
