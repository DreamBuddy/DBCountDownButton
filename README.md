### 缘由

对于做这个封装的目的就是想制造一个简单易用无风险的验证码倒计时控件吧

* 便于在多个项目使用,网络上也有很多类似的 一般分两种 :

  * 1.使用NSTimer作为定时器

  * 2.使用GCD作为定时器

* 1.NSTimer 问题最多的一个，据我了解 Timer会 retain target(有方法 处理这个 [HWWeakTimer](https://github.com/ChatGame/HWWeakTimer),具体实现我就不累赘了 请参考，issue还是有的)，一直到 倒计时结束，还会在 app 进入后台以后 出现暂停倒计时等等异常。

* 2.GCD使用起来真的是有点繁琐，这里没有多做研究，应该是可以的 但是相对来说比较繁琐

于是乎，想到了 ReactiveCocoa ,RAC处理这些问题真的是杀鸡焉用宰牛刀的赶脚啊，很轻松，而且 不会 retain 任何类，ViewController dealloc 以后 也会跟随dealloc 停止倒计时。
