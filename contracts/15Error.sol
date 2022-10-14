// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/*
异常的3种抛出方式:
1. error(参数可选)
    - error是solidity 0.8版本新加的内容，方便且高效（省gas）地向用户解释操作失败的原因。人们可以在contract之外定义异常。
2. require(异常描述字符参数可选)
    - require命令是solidity 0.8版本之前抛出异常的常用方法，目前很多主流合约仍然还在使用它。
    - 它很好用，唯一的缺点就是gas随着描述异常的字符串长度增加，比error命令要高。
    - 使用方法：require(检查条件，"异常的描述")，当检查条件不成立的时候，就会抛出异常。
3. assert
    - 和require的用法一样, 但是没有异常描述字符输入

消耗gas情况: require > assert > error

*/

contract MyError {
    mapping(uint256 => address) _owners;

    // 自定义error, 后面跟上error的名字, 用于提示用户或者作为前端的错误类型判断的标志, 名字很重要
    // 搭配revert关键字使用
    // error TransferNotOwner();
    // 带参数错误
    error TransferNotOwner(uint256 tokenId, address newOwner);

    // 方式1
    function transferOwner1(uint256 tokenId, address newOwner) public {
        if (_owners[tokenId] != msg.sender) {
            // revert TransferNotOwner();
            revert TransferNotOwner(tokenId, newOwner);
        }
        _owners[tokenId] = newOwner;
    }

    // 方式2
    function transferOwner2(uint256 tokenId, address newOwner) public {
        require(_owners[tokenId] == msg.sender, "Transfer Not Owner");
        _owners[tokenId] = newOwner;
    }

    // 方法3
    function transferOwner3(uint256 tokenId, address newOwner) public {
        assert(_owners[tokenId] == msg.sender);
        _owners[tokenId] = newOwner;
    }
}
