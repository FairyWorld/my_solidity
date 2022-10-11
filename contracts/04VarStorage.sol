// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/*
1. 数据位置(只针对引用类型: 数组, struct, mapping等)
solidity数据存储位置有三类：storage，memory和calldata。不同存储位置的gas成本不同。storage类型的数据存在链上，类似计算机的硬盘，消耗gas多；memory和calldata类型的临时存在内存里，消耗gas少。大致用法：

    storage：合约里的状态变量默认都是storage，存储在链上。

    memory：函数里的形参和临时/局部变量默认用memory，存储在内存中，不上链。

    calldata：和memory类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改（immutable），一般用于函数中不能修改的参数, 引用类型的常量。


2. 赋值规则
相同类型的不同存储类型的数据是可以相互赋值的
相同类型的数据相互赋值, 其实就是把引用赋值, 修改其中一个另一个也会变化
不同类型的数据相互赋值, 其实就是用数据部分创建了一个目标存储类型的副本, 然后赋值副本, 修改其中一个另一个不会变化
*/

contract VarStorage{
    uint[] x = [1,2,3]; // 状态变量：数组 x

    function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
        //参数为calldata数组，不能被修改
        // _x[0] = 0 //这样修改会报错
        return(_x);
    }

    function fStorage() public{
        //声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x。在debug中拖动执行的进度查看
        uint[] storage xStorage = x;
        xStorage[0] = 100;
    }

    // 函数体内的引用, 如果不显示声明存储类型会有警告    
    function fMemory() public view{
        //声明一个Memory的变量xMemory，复制x。修改xMemory不会影响x。在debug中拖动执行的进度查看
        uint[] memory xMemory = x;
        xMemory[0] = 100;
        xMemory[1] = 200;
        uint[] memory xMemory2 = x;
        xMemory2[0] = 300;
    }
}