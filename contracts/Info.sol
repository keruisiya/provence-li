pragma solidity ^0.4.17;
// import './ownable.sol';

contract Info{
    // 生成随机，用来取余数得
    uint modulus = 10 ** 16;

    // 身份字符串；
    string PRODUCE = 'produce';
    string MILKING = 'milking';
    string PROCESS = 'process';
    string STOREEXPRESS ='storeExpress';
    string SELL = 'sell';

    // 生产商部分数据的上链和获取
    struct ProduceInfo{
        // 养殖场代号id
        string farmsID;
        // 养殖场名称；
        string farmsName;
        // 养殖厂地址；
        string farmsAdd;
        // 奶牛品种；
        string cowVar;
        // 奶牛来源
        string cowSource;
        // 养殖饲料；
        string feedAqu;
        // 饲料喂养人；
        string feedName;
    }
    // 挤奶阶段数据
    struct MilkingInfo {
        // 挤奶地址编号
        string milkingAddrCode;
        // 挤奶员；
        string milkingUser;
        // 挤奶卫生情况
        string milkingEnv;
        // 挤奶时间
        string milkingTime;
    }

    // 加工阶段信息
    struct ProcessInfo {
        // 加工地址代号
        string processAddr;
        // 加工员
        string processName;
        // 加工时间
        string processTime;
        // 包装地址代号
        string balingAddr;
        // 包装员
        string balingName;
        // 加工工艺和设备
        string equiSkil;
    }

    // 存储与物流阶段数据
    struct StoreExpressInfo{
        // 仓库地址代码
        string storeAddr;
        // 仓储操作员
        string storeName;
        // 入库时间
        string storageTime;
        // 出库时间
        string retirTime;
        // 承运人
        string transName;
        // // 运输单号
        string transCode;
        // // 运输时间
        string transTime;
    }
    // 销售部分数据
    struct SellInfo{
        // 销售单号
        string sellCode;
        // 销售员
        string sellName;
        // 销售日期
        string sellTime;
        // 销售地址
        string sellAddr;
        // 保质期
        string produDate;
    }

    // 考虑是否需要这个结构？
    // 生产商集合
    address[] public produceArr;
    // jinai厂集合
    address[] public milkingArr;
    // 加工厂集合
    address[] public processArr;
    // 存储与物流集合
    address[] public storeExpressArr;
    // 销售商集合
    address[] public sellArr;

    struct Member{
        string identity;
        bool isVaild;
    }

    // 地址和对应的身份   0x123456 ===> 'produce' 
    mapping(address => Member) private addressToIdentity;
    // 给一个账户地址设定一个身份------**这个和后续准入机制有关**
    function setIdentity(address _address, string _str) public {
        require(!addressToIdentity[_address].isVaild);
        addressToIdentity[_address].identity = _str;
        addressToIdentity[_address].isVaild = true;
        if(isStrEqual(_str,PRODUCE)){
            produceArr.push(_address);
        }else if(isStrEqual(_str,MILKING)){
            milkingArr.push(_address);
        }else if(isStrEqual(_str,PROCESS)){
            processArr.push(_address);
        }else if(isStrEqual(_str,STOREEXPRESS)){
            storeExpressArr.push(_address);
        }else if(isStrEqual(_str,SELL)){
            sellArr.push(_address);
        }
    }

    // id与对应得 上传溯源信息；
    // 各身份得id数组；
    mapping(uint => ProduceInfo) public idToProduce;
    uint[] produceId;

    mapping(uint => MilkingInfo) public idToMilking;
    uint[] milkingId;

    mapping(uint => ProcessInfo) public idToProcess;
    uint[] processId;

    mapping(uint => StoreExpressInfo) public idToStoreExpress;
    uint[] storeExpressId;

    mapping(uint => SellInfo) public idToSell;
    uint[] sellId;
    

    // 数据上链成功事件定义
    event ProduceDateAdded(string _farmsID, string _farmsName, string _farmsAdd, string _cowVar, string _cowSource, string _feedAqu, string _feedName);
    event MilkingDateAdded(string _milkingAddrCode, string _milkingUser, string _milkingEnv, string _milkingTime);
    event ProcessDateAdded(string _processAddr, string _processName, string _processTime, string _balingAddr, string _balingName, string _equiSkil);
    event StoreExpressDateAdded(string _storeAddr, string _storeName, string _storageTime, string _retirTime, string _transName, string _transCode, string _transTime);
    event SellDateAdded(string _sellCode, string _sellName, string _sellTime, string _sellAddr, string _produDate);

    // 有咩有办法合成一个方法 上传数据得方法
    
    //基于当前时间生成一个id；
    function _createId() private view returns(uint){
        uint rand = uint(keccak256(now));
        return rand % modulus;
    }

    // 设置生产者信息
    function _setProduceInfo(string _farmsID, string _farmsName, string _farmsAdd, string _cowVar, string _cowSource, string _feedAqu, string _feedName) public {
        require(isStrEqual(addressToIdentity[msg.sender].identity, PRODUCE));
        uint _id = _createId();
        ProduceInfo memory produceOne = ProduceInfo(_farmsID, _farmsName, _farmsAdd, _cowVar, _cowSource, _feedAqu, _feedName);
        idToProduce[_id] = produceOne;
        produceId.push(_id);
        ProduceDateAdded(_farmsID, _farmsName, _farmsAdd, _cowVar, _cowSource, _feedAqu, _feedName);

    }

    // 设置jinai环节信息
    function _setMilkingInfo(string _milkingAddrCode, string _milkingUser, string _milkingEnv, string _milkingTime) public {
        require(isStrEqual(addressToIdentity[msg.sender].identity, MILKING));
        uint _id = _createId();
        MilkingInfo memory milkOne = MilkingInfo(_milkingAddrCode, _milkingUser, _milkingEnv, _milkingTime);
        idToMilking[_id] = milkOne;
        milkingId.push(_id);
        MilkingDateAdded(_milkingAddrCode, _milkingUser, _milkingEnv, _milkingTime);
    }

    // 设置加工环节的信息
    function _setProcessInfo(string _processAddr, string _processName, string _processTime, string _balingAddr, string _balingName, string _equiSkil) public {
        require(isStrEqual(addressToIdentity[msg.sender].identity, PROCESS));
        uint _id = _createId();
        ProcessInfo memory processOne = ProcessInfo(_processAddr, _processName, _processTime, _balingAddr, _balingName, _equiSkil);
        idToProcess[_id] = processOne;
        processId.push(_id);
        ProcessDateAdded(_processAddr, _processName, _processTime, _balingAddr, _balingName, _equiSkil);
    }

    // 设置包装物流环节信息
    function _setStoreExpressInfo(string _storeAddr, string _storeName, string _storageTime, string _retirTime, string _transName, string _transCode, string _transTime) public {
        require(isStrEqual(addressToIdentity[msg.sender].identity,STOREEXPRESS));
        uint _id = _createId();
        StoreExpressInfo memory storeExpressOne = StoreExpressInfo(_storeAddr, _storeName, _storageTime, _retirTime, _transName, _transCode, _transTime);
        idToStoreExpress[_id] = storeExpressOne;
        storeExpressId.push(_id);
        StoreExpressDateAdded(_storeAddr, _storeName, _storageTime, _retirTime, _transName, _transCode, _transTime);
    }
    
    // 设置销售环节信息
    function _setSellInfo(string _sellCode, string _sellName, string _sellTime, string _sellAddr, string _produDate) public {
        require(isStrEqual(addressToIdentity[msg.sender].identity, SELL));
        uint _id = _createId();
        SellInfo memory sellOne = SellInfo(_sellCode, _sellName, _sellTime, _sellAddr, _produDate);
        idToSell[_id] = sellOne;
        sellId.push(_id);
        SellDateAdded(_sellCode, _sellName, _sellTime, _sellAddr, _produDate);
    }
    
    // 判断字符串是否相等
    function isStrEqual(string _str1, string _str2)  public pure  returns(bool){
       return keccak256(_str1) == keccak256(_str2);
    }
}