// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Struct{
    // 结构体和对象类似

    // 1. 定义结构体形式
    struct Student{
        uint256 id;
        uint256 score; 
    }

    // 2. 声明结构体变量
    Student student;

    // 3. 直接修改结构体变量
    function initStudent1() external{
        student.id = 1;
        student.score = 80;
    }

    // 3.1. 间接修改结构体变量
    function initStudent2() external{
        // 利用存储类型相同指向同一个引用的特性, 修改相同引用的结构体, 如果student是memmory存储, 这里也要修改
        Student storage _student = student; // assign a copy of student
        _student.id = 11;
        _student.score = 100;
    }
}