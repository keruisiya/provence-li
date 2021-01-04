pragma solidity ^0.4.19;

import './Ownable.sol';
import './Utils.sol';

//json库使用不了
// import "./utils/LibString.sol";
// import "./utils/LibInt.sol";

contract Account is Ownable, Utils{
    // using LibString for * ;
    // using LibInt for *;
    // 身份字符串；
    string PRODUCE = 'produce';
    string MILKING = 'milking';
    string PROCESS = 'process';
    string STOREEXPRESS ='storeExpress';
    string SELL = 'sell';
    // 身份设定成功事件
    event identitySetSucc(address _address, string _str); 

    address[] public participateArr;
    // 这两个结构都是 有ber而来
    struct Member{
        string identity;
        bool isVaild;
    }
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

    // 判断地址数组中是否存在这个地址的方法 最高效的是用mapping判断
    // 判断是否是参与者的 定义的函数修饰符；`
    modifier onlyparticipate(address _address) {
        require(addressToIdentity[_address].isVaild);
        _;
    }
}