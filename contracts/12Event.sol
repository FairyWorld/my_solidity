// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/*
Solidity中的事件（event）是EVM上日志的抽象，它具有两个特点：
- 响应：应用程序（ether.js）可以通过RPC接口订阅和监听这些事件，并在前端做响应。
- 经济：事件是EVM上比较经济的存储数据的方式，每个大概消耗2,000 gas；相比之下，链上存储一个新变量至少需要20,000 gas。

RPC（Remote Procedure Call Protocol）远程过程调用协议
- https://blog.csdn.net/weixin_43751710/article/details/104763920
- 和http接口类似, 你不需要知道接口怎么实现, 用什么语言实现, 按照约定调用即可, 就像调用本地接口一样调用远程对象的方法

RPC接口与HTTP对比
- 传输协议。RPC：可以基于TCP协议，也可以基于HTTP协议；HTTP：基于HTTP协议
- 传输效率。RPC：使用自定义的TCP协议，可以让请求报文体积更小，或者使用HTTP2协议，也可以很好的减少报文的体积，提高传输效率；HTTP：如果是基于HTTP1.1的协议，请求中会包含很多无用的内容，如果是基于HTTP2.0，那么简单的封装下是可以作为一个RPC来使用的。
- 性能消耗。RPC：可以基于thrift实现高效的二进制传输；HTTP：大部分是通过json来实现的，字节大小和序列化耗时都比thrift要更消耗性能。
- 负载均衡。RPC：基本都自带了负载均衡策略；HTTP：需要配置Nginx，HAProxy来实现。
- 服务治理。RPC：能做到自动通知，不影响上游；HTTP：需要事先通知，修改Nginx/HAProxy配置。
*/


/*
规则
- 事件的声明由event关键字开头，然后跟事件名称，括号里面写好事件需要记录的变量类型和变量名。以ERC20代币合约的Transfer事件为例：
    - event Transfer(address indexed from, address indexed to, uint256 value);
    - Transfer事件共记录了3个变量from，to和value，分别对应代币的转账地址，接收地址和转账数量。
    - 同时from和to前面带着indexed关键字，每个indexed标记的变量可以理解为检索事件的索引“键”，
        - 参考以太坊j交易事件信息图片: https://wtf.academy/assets/images/12-3-b08311699b4378c7b077f1cd966b51e2.jpg
        - 在以太坊上单独作为一个topic进行存储和索引，程序可以轻松的筛选出特定转账地址和接收地址的转账事件。
        - 每个事件最多有3个带indexed的变量。每个 indexed 变量的大小为固定的256比特。
        - 事件的哈希以及这三个带indexed的变量在EVM日志中通常被存储为topic。
        - 其中topic[0]是此事件的keccak256哈希，topic[1]到topic[3]存储了带indexed变量的keccak256哈希。
    - value 不带 indexed 关键字，会存储在事件的 data 部分中，可以理解为事件的“值”。
        - data 部分的变量不能被直接检索，但可以存储任意大小的数据。
        - 因此一般 data 部分可以用来存储复杂的数据结构，例如数组和字符串等等，因为这些数据超过了256比特
        - 即使存储在事件的 topic 部分中，也是以哈希的方式存储。
        - 另外，data 部分的变量在存储上消耗的gas相比于 topic 更少。

*/
contract Event{
    // 定义事件
    event Transfer(address indexed from, address indexed to, uint256 value);
    mapping(address => uint256) public balances;
    address public testFrom = address(0);
    address public testTo = address(1);
    
    function transfer(address from, address to, uint256 value) public {
        // 假设from有钱
        balances[from] = 10000;
        // 转账
        balances[from] -= value;
        balances[to] += value;

        // 发射事件
        // 在remix的debug, logs可以看到
        emit Transfer(from, to , value);
    }
 }