// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// 修饰器（modifier）是solidity特有的语法，类似于面向对象编程中的decorator，声明函数拥有的特性，并减少代码冗余
// modifier的主要使用场景是运行函数前的检查，例如地址，变量，余额等。或者对数据进行预处理

contract Decorator {
    address public owner;
    address public testNewOwnerAddress = address(0);

    constructor() {
        owner = msg.sender;
    }

    // 定义一个modifier
    modifier onlyOwner{
        require(msg.sender == owner, "you is not owner");
        // _;表示执行函数主体, 这里表示满足require再执行函数主体
        _;
    }

    // 使用modifier
    // 只有当前owner才能修改owner
    function setOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}
