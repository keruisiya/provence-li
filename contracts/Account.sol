pragma solidity ^0.4.19;

import './Ownable.sol';
import './Utils.sol';

contract Account is Ownable, Utils{
    // 身份字符串；
    string PRODUCE = 'produce';
    string MILKING = 'milking';
    string PROCESS = 'process';
    string STOREEXPRESS ='storeExpress';
    string SELL = 'sell';

    // 参与方集合---为了循环mapping
    // address[] public participateArr;

    // 考虑是否需要这个结构？
    // 生产商集合
    // address[] public produceArr;
    // jinai厂集合
    // address[] public milkingArr;
    // 加工厂集合
    // address[] public processArr;
    // 存储与物流集合
    // address[] public storeExpressArr;
    // 销售商集合
    // address[] public sellArr;

    // 身份设定成功事件
    event identitySetSucc(address _address, string _str); 

    address[] public participateArr;
    // 这两个结构都是 有ber而来
    struct Member{
        string identity;
        bool isVaild;
    }
    // // 为了getAllIdentity返回值所设的结构
    // struct MemberInfo{
    //     address accountAdd;
    //     string identity;
    // }
    // 如果要指定权限就去掉public 使用getAllIdentity获取
    // MemberInfo[] public participateArr;

    // 地址和对应的身份   0x123456 ===> 'produce' ---为了方便根据地址查询身份的方便
    mapping(address => Member) public addressToIdentity;
    // 给一个账户地址设定一个身份------**这个和后续准入机制有关**
    function setIdentity(address _address, string _str) public {
        require(!addressToIdentity[_address].isVaild);
        addressToIdentity[_address].identity = _str;
        addressToIdentity[_address].isVaild = true;
        participateArr.push(_address);
        // participateArr.push(MemberInfo(_address,_str));
        identitySetSucc(_address, _str);
    }

    // 放回参与方地址集合的 数组长度
    function getIdentityArrLength() public view returns(uint){
        return participateArr.length;
    }
    
    // 展示所有的参与者身份---------solidity无法返回结构体形式的数组
    function getIdentity(address _address) public view returns(string){
        return addressToIdentity[_address].identity;
    }


    // 判断地址数组中是否存在这个地址的方法 最高效的是用mapping判断
    // 判断是否是参与者的 定义的函数修饰符；`
    modifier onlyparticipate(address _address) {
        require(addressToIdentity[_address].isVaild);
        _;
    }
}