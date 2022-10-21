# minpg 用于设计算法竞赛题目的简易脚本

基于 [testlib](https://github.com/MikeMirzayanov/testlib) 及 Linux 运行环境

## 为什么使用 testlib ? 

使用 testlib 有以下几个好处：

1. 大量方便的工具函数，减轻生成数据的码量；
2. 用输入作为随机数种子的固定随机方式，保证了即使在不同的时空，只要给定相同的参数，就能得到相同的输出。也就是说，我们只要保留代码和参数，就能复原一模一样的数据，大大降低了硬盘/云空间占用；
3. 兼容 Codeforces。

## 为什么使用 Linux ?

1. 我喜欢；
2. 使用和评测机更接近的运行环境，降低运行环境不同导致出错的可能。

## 使用教程

### 准备工作

1. 把这个仓库 fork 一份到自己的 github 账户底下；
2. 把 fork 过来的仓库 clone 到本地；

### 出一道 A + B Problem

在 clone 下来的仓库的根目录下输入命令:

```
./makefile.sh AplusB
```
根目录下就会出现一个叫做AplusB的文件夹。你需要在该文件夹里的`std.cpp`写入本题的标准代码，`gen.cpp`写入用于生成数据输入的代码，以及在`scripts.in`写入用于生成测试数据的参数，`samples.in`写入用于生成样例数据的参数。

以 A + B Problem 为例，写出来的 `std.cpp` 是:

```
#include <cstdio>
using namespace std;
int main() {
    int a, b;
    scanf("%d%d", &a, &b);
    printf("%d", a + b);
    return 0;
}
```
`gen.cpp`则是：

```
#include <bits/stdc++.h>
#include "testlib.h"
int main(int argc, char *argv[]) {
    registerGen(argc, argv, 1);
    int l = opt<int>(1);
    int r = opt<int>(2);
    println(rnd.next(l, r), rnd.next(l, r));
}
```

这一份`gen.cpp`将传入的参数作为 a 和 b 的值域，在这个值域范围内随机生成数据。
根据需要，`gen.cpp`可以写得很复杂。具体可以参考Codeforces上的博客。

然后，我们在 `scripts.in` 设计每组数据对应的参数。每行对应一组数据。注意最后一行不会被识别到，可以在最后一行换行或者加点注释。

```
1 2
1 100
500000000 1000000000
END
```

`samples.in` 其实和 `scripts.in` 是一样的，只是生成的数据文件名不同。

最后，我们回到根目录，输入命令：

```
./doall.sh AplusB
```
等待运行。运行结束，就能在 AplusB/tests/目录下看到所有数据了。



