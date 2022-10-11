// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/*
数组:
固定长度数组: uint[8] array1; bytes1[5] array2; address[100] array3;

可变长度数组(动态数组): uint[] array4; bytes1[] array5; address[] array6; bytes array7;
    - bytes数组比较特殊, 不需要[]

创建数组:
    - new uint[](长度);
    - 字面量: [1, 2, 3];

字面量数组注意点:
- 字面量数组的类型以第一个元素的类型为标准, [1, 2, 3]以1的类型为准.
- 没有明确指明类型, 默认是推断类型中最小单位的类型, 1属于uint, uint8, uint16, uint256, 最小单位为uint8
- 所以[1, 2, 3]为uint8[]类型, 如果赋值给uint[]类型就会报错.
- 转换数组类型: [uint256(1), 2, 3]为uint256[]类型

数组成员
length: 数组有一个包含元素数量的length成员，memory数组的长度在创建后是固定的。
动态数组独有:
push(): 动态数组和bytes拥有push()成员，可以在数组最后添加一个0元素。
push(x): 动态数组和bytes拥有push(x)成员，可以在数组最后添加一个x元素。
pop(): 动态数组和bytes拥有pop()成员，可以移除数组最后一个元素。


注意点:
- memory存储类型的动态数组, 一旦初始化长度后, 就固定长度了
*/
contract Array{
    uint[] public arr1;
    uint[] public  arr2 = new uint[](5);
    uint8[] public arr3 = [1, 2, 3];

    function f() public pure {
        // g([1, 2, 3]); // unit8类型不对
        g([uint(1), 2, 3]);
    }

    function g(uint[3] memory) public pure {
        // ...
    }
}