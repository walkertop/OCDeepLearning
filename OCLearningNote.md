# OC学习Note
> 记录学习的一些trick,开发的tips及其偏片段的一些知识点。

* Mac OS 上打开通用的Router
```
x-help-action://openPrefPane?bundleId=com.apple.preference.security&anchorId=General
```
所以MacOS的路由，本身也是通过URL来处理的。

* Fix:
调用**objc_msgSend()**时，方法报错：
```objc_msgSend(): Too many arguments to function call ,expected 0,have2;```
报错原因：Xcode对objc_msgSend()有严格的类型检查
修改办法：
在build settings中，将
`Build Setting--> Apple LLVM  - Preprocessing--> Enable Strict Checking of objc_msgSend Calls  改为 NO`
> **NOTE:**在Xcode10中，为
`Build Setting--> Apple Clang  - Preprocessing--> Enable Strict Checking of objc_msgSend Calls  改为 NO`

* Xcode10中，将build settings 中的Apple LLVM改为Apple Clang；


