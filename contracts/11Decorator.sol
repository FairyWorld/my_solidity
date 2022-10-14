// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// 修饰器（modifier）是solidity特有的语法，类似于面向对象编程中的decorator，声明函数拥有的特性，并减少代码冗余
// modifier的主要使用场景是运行函数前的检查，例如地址，变量，余额等。或者对数据进行预处理或者后置处理
// 多个修改器的顺序, 前置修改器按照书写的顺序(越靠前优先级越高), 后置修改器按照书写的逆序(越靠后优先级越高)

contract Decorator {
    address public owner;
    address public testNewOwnerAddress = address(0);
    uint8[] public arr;

    constructor() {
        owner = msg.sender;
    }

    // 定义一个前置modifier
    modifier onlyOwner{
        require(msg.sender == owner, "you is not owner");
        arr.push(1);
        // _;表示执行函数主体, 这里表示满足require再执行函数主体
        _;
    }

    // 定义一个前置modifier
    modifier startModify{
        arr.push(2);
        _;
    }

    // 定义一个后置modifier
    modifier endModify1{
        _;
        arr.push(4);
    }

    // 定义一个后置modifier
    modifier endModify2{
        _;
        arr.push(5);
    }

    // 使用modifier
    // 只有当前owner才能修改owner
    // 2,1,3,5,4
    // 多个修改器的顺序, 前置修改器按照书写的顺序(越靠前优先级越高), 后置修改器按照书写的逆序(越靠后优先级越高)
    function setOwner(address newOwner) public startModify onlyOwner endModify1 endModify2  {
        // owner = newOwner;
        // arr.push(3);
    }
}
