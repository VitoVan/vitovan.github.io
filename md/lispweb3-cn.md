<!--1-->
# Lisp 与现代Web开发

2015/08，修订：2015/08, 2015/11, 2016/08

_For those who have read [Lisp for The Modern Web](lispweb3.html): SKIP, please. This is just another language version._

> Lisp 不是一门语言，它是一种构建素材。

\-  艾伦·凯

### 我们要讲什么？

本文将介绍如何从零开始使用 Lisp 作为后端构建一个现代的 Web 应用程序。

你可能需要一些前端开发的知识（如 Ajax 通信等），因为关于客户端这一方面我们将不再赘述。

### 为什么要用 Lisp？

**因为它很酷**。

我是脑残我自豪，是不是神器又怎么样？光名字就看起来很牛的样子（好多人都不会喔 <(￣ˇ￣)/ ）。

从 Lisp 诞生至今已有 57 年，半个多世纪。什么概念呢？除了 Fortran 没有谁比 Lisp 更古老了，而很少有人说 Fortran 很酷。

你可以在几乎所有的语言当中看到 Lisp 的影子，因为真的：Lisp 不是一门语言，她是人机对话的基本元素。

**其它原因**.

其它关于 Lisp 的赞美，你可以参考一下阮一峰翻译的[《为什么Lisp语言如此先进？》](http://www.ruanyifeng.com/blog/2010/10/why_lisp_is_superior.html)，以及我非常建议你看完这本书：[《黑客与画家》](http://book.douban.com/subject/6021440/)。

### 让我们开始吧

开始做什么？

从 0 开始使用 Lisp 作为后端构建一个现代的 Web 应用程序。

怎么做？

最近大多数的 Web App 都是用 **`输出 JSON 的服务器`** 加上 **`解析 JSON 并展示的 HTML5 客户端`** 构成的，我们就也照着这个模式来吧。

因为大家对如何构建一个 Web App 客户端都比较熟悉，所以关于客户端构建部分，就不再赘述，直接提供源码了。

### 步骤

* [你好， Lisp！](#你好lisp)
* [面向世界的编程](#面向世界的编程)
* [他们都喜欢 JSON](#他们都喜欢-json)
* [把数据存起来](#把数据存起来)
* [我们的客户端](#我们的客户端)

#### 你好，Lisp！

这里我们假设你对 Lisp 一无所知，所以，我们先跟 Lisp 打声招呼：

* 打开 [sbcl.org](http://sbcl.org/), 然后点击 [Download](http://sbcl.org/platform-table.html) 页面, 选择适合你电脑的二进制包。

* 然后跟着 [Getting Started](http://sbcl.org/getting.html) 把它安装一下。

* 然后运行 `sbcl` ，你就得到了一个 [REPL](http://www.cliki.net/REPL) (Read Eval Print Loop)！


>This is SBCL 1.2.7, an implementation of ANSI Common Lisp.

>More information about SBCL is available at <http://www.sbcl.org/>.

>

>SBCL is free software, provided as is, with absolutely no warranty.

>It is mostly in the public domain; some portions are provided under

>BSD-style licenses.  See the CREDITS and COPYING files in the

>distribution for more information.

>\*


在我们开始编码之前，先了解一下 Lisp 的基本语法。很多人说它很怪，实际上这正是 Lisp 的魅力所在。

我想你肯定玩儿过一款游戏，叫做：吃豆人。如果没有玩儿过的同学可以先去[玩一下](http://www.webpacman.com/pacman.php)，再接着回来上课，那玩儿过的同学我们就继续了。

你可以把 Lisp 程序执行的过程想象成为吃豆人吃豆子： `ᗧ••••` ，是没有小鬼怪的版本。吃豆人就是 Lisp 里面的函数，而豆子是函数的参数。当一个吃豆人把它面前的所有的豆子吃光时，它自己也就变成了一颗豆子： `•` 。然后豆子呢，又可以被其他的吃豆人吃掉。

因此，你可以把一个 Lisp 程序想像成下面这个样子：

```Lisp
;;第一天，我们创造了吃豆人和豆子，他们在各自的括号里，相安无事。
(ᗧ• (ᗧ••••
 (ᗧ••
 (ᗧ•••))))
;;第二天，最里边的吃豆人开始了疯狂的杀戮，吃掉了自己面前所有的豆子，
;;然后自个儿也变成了豆子
(ᗧ• (ᗧ••••
 (ᗧ••
 •)))
;;第三天，杀戮仍在继续
(ᗧ• (ᗧ••••
•))
;;第四天，只剩最后一个吃豆人了
(ᗧ• •)
;;第五天，原来一切都只是豆子
•
```

哈！有没有很有趣的样子？ =￣ω￣=

一切都只是吃豆人和豆子！靠在括号最里面的吃豆人先吃，然后变成豆子，接着被更外一层的吃豆人吃掉。听起来好残忍的样子，o((⊙﹏⊙))o.

好了，让我们回到正经事上：


* 在你打开的 REPL 里输入 `(format t "你好，Lisp！")` ，没错就是中文，然后按 <kbd>回车</kbd>

>\* (format t "你好，Lisp！")

>**你好，Lisp！**

>NIL

>\* 

* 好了，你已经学会 Lisp 啦！下课！

「 Σ(っ °Д °;)っ 老湿！不是吧老湿！退不退学费呀哎～～ 」

那好吧，我们来说一些复杂一点的：

* 打开一个文件，把下面的代码粘进去, 然后保存一下，命名： `say-hello.lisp` ：

```Lisp
(defun say-hello (to)
 (format t "你好， ~a" to))
```

* 打开一个终端，切换到当前目录，然后

* 输入 `sbcl --load say-hello.lisp` ，按 <kbd>回车</kbd>

>[vito@laptop lispweb3-cn]$ sbcl --load say-hello.lisp

>This is SBCL 1.2.7, an implementation of ANSI Common Lisp.

>More information about SBCL is available at <http://www.sbcl.org/>.

>

>SBCL is free software, provided as is, with absolutely no warranty.

>It is mostly in the public domain; some portions are provided under

>BSD-style licenses.  See the CREDITS and COPYING files in the

>distribution for more information.

>\*

* 然后你就得到了一个加载了那个文件的 REPL，接下来输入 `(say-hello "Vito")` ，按 <kbd>回车</kbd>

>\* (say-hello "Vito")

>**你好, Vito**

>NIL

>\*

* 「天呐！我的上帝，你刚刚用 Lisp 对我说了 “你好”！」，「哦，是么！这没什么大惊小怪的，镇定点伙计！」(翻译腔)

**嗯...... 刚才发生了什么？**

首先， 当我们输入 `(format t "你好，Lisp！")` 时，我们调用了一个函数叫做： `format` ，然后传递了两个参数： `t` 和 `"你好，Lisp！"` 。那么， `format` 是什么？

如果是英文读者，可以直接去 Google 搜索：[_common lisp format_](https://www.google.com/search?q=common+lisp+format)，基本上都能找到自己想要找的答案，如：[CLHS: Function FORMAT](http://www.lispworks.com/documentation/lw50/CLHS/Body/f_format.htm) 和 [A Few FORMAT Recipes](http://www.gigamonkeys.com/book/a-few-format-recipes.html)。

而对于中文读者的话，资料就稍微少一些，可以参考一下：[《ANSI Common Lisp 中文版》](http://acl.readthedocs.org/en/latest/zhCN/index.html) 的 [2.9 输入输出 (Input and Output)](http://acl.readthedocs.org/en/latest/zhCN/ch2-cn.html#input-and-output) 这一章，里边有关于 `format` 函数的简单解释（实际上我建议大家可以没事儿的时候就翻一翻[《ANSI Common Lisp 中文版》](http://acl.readthedocs.org/en/latest/zhCN/index.html)，译得很好）。

当然百度也是可以用来搜索的，只是结果中的干扰信息太多。

>......

>最普遍的 Common Lisp 输出函数是 format 。接受两个或两个以上的实参，第一个实参决定输出要打印到哪里，第二个实参是字符串模版，而剩余的实参，通常是要插入到字符串模版，用打印表示法（printed representation）所表示的对象。

>......

>format 的第一个实参 t ，表示输出被送到缺省的地方去。通常是顶层。第二个实参是一个用作输出模版的字符串。在这字符串里，每一个 ~A 表示了被填入的位置，而 ~% 表示一个换行。这些被填入的位置依序由后面的实参填入。

>......

\- [《ANSI Common Lisp 中文版》：2.9 输入输出 (Input and Output)](http://acl.readthedocs.org/en/latest/zhCN/ch2-cn.html#input-and-output)

好了，那么现在我们知道了： `(format t "你好，Lisp！")` 的第一个参数是打印目的地，当我们赋值为 `t` 时，意思就是打印到标准控制台了。然后第二个参数就是模板字符串，当里边没有像 `~A` 之类的打印指令时，就仅仅是普通的字符串啦。

所以呢， `(format t "你好，Lisp！")` 意思就是說把字符串： `"你好，Lisp！"` 打印到标准控制台。

接着，我们往一个文件里写了如下代码：

```Lisp
(defun say-hello (to)
 (format t "你好， ~a" to))
```

根据前边的介绍，我们知道 `(format t "你好，~a")` 意思是把 `~a` 替换成变量 `to` 的值，然后把它们打印到控制台上，那 `defun` 是干什么用的？

同学们看这里：[《ANSI Common Lisp 中文版》：2.6 函数 (Functions)](http://acl.readthedocs.org/en/latest/zhCN/ch2-cn.html#functions) (多看文档总是没有坏处的啦，我大景德也有足够的料喔~)

看过之后呢，我们知道 `defun` 实际上就是用来定义函数的，就像 JavaScript 里面的 `function` 。 `defun` 紧跟着的第一个参数是函数的名字，第二个是函数的参数列表（用括号括起来的），然后剩下来的通常就是函数体了。

所以，那段代码的意思就是说：我们创建了一个叫做 `say-hello` 的函数，这个函数接受一个叫做 `to` 的参数，当函数被调用时，它把变量 `to` 的值和字符串 `"你好， "` 连到了一块儿，然后打印到控制台上。下面这个是类似的 JavaScript 版本：

```JavaScript
//好像 JavaScript 里没有字符串格式化的函数，所以......
function sayHello(to){
    console.log("你好， ~a".replace("~a",to));
}
```

#### 面向世界的编程

现在我们已经知道了如何用 Lisp 编程（[手册](http://acl.readthedocs.org/en/latest/zhCN/index.html)在手，就敢说大话）。但是除了你我，没人知道啊～让我们用 Lisp 建个服务器来告诉全世界吧！

>如果说我比别人看得更远些,那是因为我站在了巨人的肩上. 

\- 艾萨克·牛顿

让我们一起来见一见巨人们：

* 打开 [quicklisp.org](http://quicklisp.org)，然后根据 [安装步骤](https://www.quicklisp.org/beta/#installation) （如果你有些不知道怎么办的话，可以直接把深灰色背景段落内的所有粗体 复制 -> 粘贴 -> 并在你的终端里执行就好了)，安装一下。

* 打开一个文件，复制粘贴下面的代码，然后保存为：`server.lisp`

```Lisp
(ql:quickload :hunchentoot)
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
```

* 打开终端，切换到文件所在目录

* 输入 `sbcl --load server.lisp`， 按 <kbd>回车</kbd>

* 等待加载完毕，然后用你最喜欢的浏览器打开：[http://localhost:4242/](http://localhost:4242/)

* 「 w(ﾟДﾟ)w 天呐，这不是真的！」

* 「妈，我用 Lisp 建了个网站！」


让我们先镇定一下，这么一个默认页面是不足以让人觉得是_你_用 Lisp 建了个网站的。把下面的代码加到 `server.lisp` 里：

```Lisp
 ;;记得 Vito 换成你的名字
(hunchentoot:define-easy-handler (say-hello :uri "/hello") (name)
 (setf (hunchentoot:content-type*) "text/plain")
 (format nil "嘿, ~a! 我是 Vito! ~%我刚刚用 Lisp 建了个网站！" name))
```

* 然后按 <kbd>Ctrl</kbd> + <kbd>d</kbd> 或者输入 `(quit)` 按 <kbd>回车</kbd> 来退出当前 REPL 。

* 在终端里打： `sbcl --load server.lisp` ，再按 <kbd>回车</kbd>。

* 等待加载完毕，点击这里： [http://localhost:4242/hello?name=世界](http://localhost:4242/hello?name=世界)

* 嗯，这样看起来才像话么～

**我们刚才做了什么？**

实际上也并没有很难理解，对吧。

首先，多亏了 Quicklisp，它就相当于 Lisp 世界的包管理器。有了 Quicklisp ，我们才站在了巨人的肩膀上。在 Quicklisp 里，有[将近 1,200 个包](https://www.quicklisp.org/beta/releases.html)，虽然不多吧，但足够用了。有了它，就像是站在了风口，后果可想而知。

其次，感谢巨人 [Edi Weitz](http://weitz.de/)，我们用了他（她）写的 [Hunchentoot](http://weitz.de/hunchentoot/) [\[1\]](#fn1) 作为我们的服务端实现。

我们刚才用 Quicklisp 加载了 Hunchentoot，像这样： `(ql:quickload :hunchentoot)`，然后在 4242 端口启动了 Hunchentoot 服务： `(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))`，最后，我们用 Hunchentoot 的 [define-easy-handler](http://weitz.de/hunchentoot/#define-easy-handler) 定义了一个名字叫做 `say-hello` 的 Handler。

关于 Hunchentoot 的使用，没有找到相关的中文资料，大家可以直接去读原版文档：[Hunchentoot - The Common Lisp web server formerly known as TBNL](http://weitz.de/hunchentoot)。关于 Quicklisp ，学会 `(ql:quickload ...` 这一招基本就通吃天下了，其他的可以参考这里：[Quicklisp: Basic Commands](https://www.quicklisp.org/beta/#basic-commands)。

#### 他们都喜欢 JSON

> 不行，绝对不行。是的，只要 JSON。嗯，好了好了别跟我扯别的，只要 JSON 格式的，其他的不考虑。是的，一人一个 MBP 也不行。

\- 刚才前端团队打来电话说

他们都喜欢 [JSON](http://json.org/)。

那，让我们来实现他们的愿望：

* 打开一个文件，复制粘贴以下代码，保存为 `json-server.lisp`：

```Lisp
(ql:quickload '(hunchentoot cl-json))
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
;;定义一个 people 类
;;类？
;;嗯，没错伙计，这是一个类。Lisp 可不只是一个函数式编程语言。
(defclass people()
  ((name :accessor name
         :initarg :name)
   (language :accessor language
             :initarg :language)
   (words :accessor words
        :initarg :words)))
;;Make a people.
(defvar me
  (make-instance 'people
                 :name "Vito Van"
                 :language "Lisp"
                 :words "所以说做妖就象做人一样，要有仁慈的心，有了仁慈的心呢，后果可想而知。"))
;;用 JSON 给前端盆友打个招呼
(hunchentoot:define-easy-handler (say-me :uri "/me") ()
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string me))
;;根据参数构建一个 people 对象，转换成 JSON 然后返回
(hunchentoot:define-easy-handler (say-you :uri "/you") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (make-instance
    'people
    :name name
    :language "中文"
    :words (format nil "~a，你尽管捅死我吧，生又何哀，死又何苦，等你明白了舍生取义，后果可想而知。 " name))))
```

* 退出所有打开的 REPL ，然后加载这个文件：`sbcl --load json-server.lisp`。

* 点击这里： [http://localhost:4242/me](http://localhost:4242/me)， 和这里： [http://localhost:4242/you?name=悟空](http://localhost:4242/you?name=悟空) (如果你看到了类似 `\u4E2D\u6587` 这样的结果，请打开浏览器的开发者工具，然后点击 Network 那一览进行监视)

嗯～干的不错！

到现在不用再过多解释了吧～

首先，我们定义了一个类，然后创建了一些实例，然后把那些实例转换成了 JSON 格式，然后返回给了我们的前端团队。这里是关于 `defclass` 相关的介绍：[《ANSI Common Lisp 中文版 》：第十一章：Common Lisp 对象系统](http://acl.readthedocs.org/en/latest/zhCN/ch11-cn.html)，然后这个是 `cl-json` ： [CL-JSON](https://common-lisp.net/project/cl-json/)（一个 JSON 解析/生成器）

#### 把数据存起来

现在到哪一步了？

我们刚刚建了一个 **`输出 JSON 的服务器`**，很牛的样子，但是我们还没有存储过任何数据。接下来，让我们把每个访问 [http://localhost:4242/you?name=悟空](http://localhost:4242/you?name=悟空) 的人都记下来。

下面是处理这个请求的代码：

```Lisp
;;根据参数构建一个 people 对象，转换成 JSON 然后返回
(hunchentoot:define-easy-handler (say-you :uri "/you") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (make-instance
    'people
    :name name
    :language "中文"
    :words (format nil "~a，你尽管捅死我吧，生又何哀，死又何苦，等你明白了舍生取义，后果可想而知。 " name))))
```

让我们调整一下：

```Lisp
;;保存 people 对象
(defun store-people (people)
  (ᗧ• people •)
  people)
;;创建 people 对象
(defun make-people (name)
  (make-instance
   'people
   :name name
   :language "中文"
   :words (format nil "~a，你尽管捅死我吧，生又何哀，死又何苦，等你明白了舍生取义，后果可想而知。" name)))
;;根据参数构建一个 people 对象，转换成 JSON 然后返回
(hunchentoot:define-easy-handler (say-you :uri "/you") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (store-people
    (make-people name))))
```
我们添加了一个叫 `make-people` 的函数，使代码更整洁一些。然后...... 你肯定知道 `store-people` 这个函数还不能用，对吧，<(*￣▽￣*)/。

我们平时都是怎么存储数据的？数据库：Oracle / MySQL / MongoDB ...... 好多好多等等等等。今儿咱不用数据库，因为：

* 一点儿都不酷啊！一点都不酷！(* ￣︿￣)

* 很复杂！！很复杂！！有些还要学 SQL！！到现在都不知道 GROUP BY 怎么用啊大姐！！

* 为什么不能放到内存里？现在内存条都白菜价了，速度还快～

所以呢，我们决定这样做：

```Lisp
(defvar *people-list* nil)
;;保存 people 对象
(defun store-people (people)
  (push people *people-list*)
  people)
```

ヾ(≧▽≦*)o o o 哈哈哈哈！哈哈哈哈！没错！就这么简单！是的就这么简单！为什么不能这样做！？哈哈哈哈！！

我们仅仅是创建了一个变量，叫做 `*people-list*`，然后把生成的 `people` 对象存储了进去。哈哈哈哈！（让我再笑一会儿）

然后我们把 `*people-list*` 列表返回给浏览器：

```Lisp
(hunchentoot:define-easy-handler (people :uri "/people") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   *people-list*))
```

下面是这个内存存储的相关代码（剔除了其他的）：

```Lisp
(ql:quickload '(hunchentoot cl-json))
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
;;定义 people 类
(defclass people()
  ((name :accessor name
         :initarg :name)
   (language :accessor language
             :initarg :language)
   (words :accessor words
        :initarg :words)))
;;定义一个列表
(defvar *people-list* nil)
;;保存 people 对象
(defun store-people (people)
  (push people *people-list*)
  people)
;;创建 people 对象
(defun make-people (name)
  (make-instance
   'people
   :name name
   :language "中文"
   :words (format nil "~a，你尽管捅死我吧，生又何哀，死又何苦，等你明白了舍生取义，后果可想而知。" name)))
;;根据参数构建一个 people 对象，转换成 JSON 然后返回
(hunchentoot:define-easy-handler (say-you :uri "/you") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (store-people
   (make-people name))))
;;返回 people 列表
(hunchentoot:define-easy-handler (people :uri "/people") ()
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   *people-list*))
```

你可以把这段代码保存为 `storage-server.lisp` ，然后加载：`sbcl --load storage-server.lisp` （为避免端口冲突，先退出所有其他的 REPLs）。

加载这后，先点击这里： [悟空](http://localhost:4242/you?name=悟空), 这里：[晶晶](http://localhost:4242/you?name=晶晶),和这里： [紫霞](http://localhost:4242/you?name=紫霞)。

然后看看是否已经保存：[http://localhost:4242/people](http://localhost:4242/people).

怎么样？没问题吧～

**这要是断电了，老板不得掐死我？**

你说的有道理。

虽然我们决定不用数据库产品了，不代表我们解决不了这个问题。我们可以用一种更酷的方式，叫做：[OBJECT PREVALENCE](http://www.advogato.org/article/398.html)，还没有找到合适的中文翻译，暂且叫它：对象流行持久化。而流行持久化系统是一种使用内存存储对象，并提供快速查找以及事务处理等功能的系统。

通常情况下，一个流行持久化系统都具有快照的功能，来将数据从内存直接映射到硬盘上，来解决断电问题。在下次启动或任何需要的时候，从硬盘加载进来。

我们当然可以自己实现一套么，可是造轮子太辛苦了，我们可以看看巨人们在这一方面都走到哪里了。

经过搜索我们找到一个 Common Lisp 的实现：[CL-PREVALENCE](https://common-lisp.net/project/cl-prevalence/)，是由 [Sven Van Caekenberghe](http://www.cliki.net/Sven Van Caekenberghe) 开发的。虽然文档和功能都不是很全，但也基本能用了。更何况我们有 [API](https://common-lisp.net/project/cl-prevalence/CL-PREVALENCE.html) 和[源码](https://bitbucket.org/skypher/cl-prevalence/)呢，不怕。

* 首先，我们使用 Quicklisp 加载 `cl-prevalence` ：

```Lisp
(ql:quickload '(hunchentoot cl-json cl-prevalence))
```

* 然后初始化流行持久化系统 （我们将类定义在初始化之前是因为系统在初始化时，需要用到类定义来进行数据加载）：

```Lisp
;;我们为 people 新增了一个 id 字段，为方便流行持久化系统使用
(defclass people()
  ((id :reader id
       :initarg :id)
   (name :accessor name
         :initarg :name)
   (language :accessor language
             :initarg :language)
   (words :accessor words
        :initarg :words)))
;;初始化系统
(defvar *p-system* (cl-prevalence:make-prevalence-system #p"./p-system/"))
;;创建计数器
(or (> (length (cl-prevalence:find-all-objects *p-system* 'people)) 0)
	(cl-prevalence:tx-create-id-counter *p-system*))
```

* 然后修改我们的 `make-people` 函数，使其直接将对象创建于流行持久化系统内：

```Lisp
(defun make-people (name)
  (cl-prevalence:tx-create-object
   *p-system*
   'people
   `((name ,name)
     (language ,"中文")
     (words ,(format nil "~a，你尽管捅死我吧，生又何哀，死又何苦，等你明白了舍生取义，后果可想而知。" name)))))
```
* 然后删除 `store-people` 和 `*people-list*`，因为我们的 `people` 对象已经在创建的时候自动存储于流行持久化系统内了。

* 调整控制器，使其从流行持久化系统内获取数据：

```Lisp
;;根据参数构建一个 people 对象，转换成 JSON 然后返回
(hunchentoot:define-easy-handler (say-you :uri "/you") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (make-people name)))
;;获取流行持久化系统内所有的 people 实例
(hunchentoot:define-easy-handler (people :uri "/people") ()
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (cl-prevalence:find-all-objects *p-system* 'people)))
```

* 最后我们得到了以下代码：

```Lisp
(ql:quickload '(hunchentoot cl-json cl-prevalence))
;;我们为 people 新增了一个 id 字段，为方便流行持久化系统使用
(defclass people()
  ((id :reader id
       :initarg :id)
   (name :accessor name
         :initarg :name)
   (language :accessor language
             :initarg :language)
   (words :accessor words
        :initarg :words)))
;;初始化系统
(defvar *p-system* (cl-prevalence:make-prevalence-system #p"./p-system/"))
;;创建计数器
(or (> (length (cl-prevalence:find-all-objects *p-system* 'people)) 0)
	(cl-prevalence:tx-create-id-counter *p-system*))
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
;;创建 people 对象至流行持久化系统
(defun make-people (name)
  (cl-prevalence:tx-create-object
   *p-system*
   'people
   `((name ,name)
     (language ,"中文")
     (words ,(format nil "~a，你尽管捅死我吧，生又何哀，死又何苦，等你明白了舍生取义，后果可想而知。" name)))))
;;根据参数构建一个 people 对象，转换成 JSON 然后返回
(hunchentoot:define-easy-handler (say-you :uri "/you") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (make-people name)))
;;获取流行持久化系统内所有的 people 实例
(hunchentoot:define-easy-handler (people :uri "/people") ()
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (cl-prevalence:find-all-objects *p-system* 'people)))
```

* 把上面的代码保存到 `p-storage-server.lisp`，然后加载： `sbcl --load p-storage-server.lisp` （同样，记得退出所有其他的 REPL，避免端口冲突）。


然后点击这里： [至尊宝](http://localhost:4242/you?name=至尊宝)，这里： [晶晶](http://localhost:4242/you?name=晶晶)，这里： [紫霞仙子](http://localhost:4242/you?name=紫霞仙子)，以及这里 [牛魔王](http://localhost:4242/you?name=牛魔王)。

然后再点击这里：[http://localhost:4242/people](http://localhost:4242/people).

怎么样？是不是和使用 `*people-list*` 时效果一样？

**见证奇迹的时刻**

现在，在你的 REPL 里输入： `(cl-prevalence:snapshot *p-system*)` ，然后按 <kbd>回车</kbd>.

接下来，退出所有的 REPL，关闭所有的浏览器标签页（除了这个）。

重新载入代码：`sbcl --load p-storage-server.lisp`，然后再打开这里：[http://localhost:4242/people](http://localhost:4242/people)。

紫霞仙子还在不在？我们的流行持久化系统自动把数据加载了回来！

#### 我们的客户端

我创建了一个单文件的客户端，你可以[下载](lispweb3-cn/lispweb3-cn-client.htm) 修改它，里边是 HTML / JavaScript 和 CSS 代码。

**接下来还剩什么？**

我们需要托管这个静态文件，来一起看看 [Hunchentoot 文档](http://weitz.de/hunchentoot/#start)：

>...... The location of the document root directory can be specified when creating a new ACCEPTOR instance by the way of the ACCEPTOR-DOCUMENT-ROOT. . ......

\- [Hunchentoot 文档](http://weitz.de/hunchentoot/)

那接下来要做的就是在 `p-storage-server.lisp` 同级目录创建一个文件夹 `www`，然后把静态文件放进去：

```Lisp
wget -P www http://vito.sdf.org/lispweb3-cn/lispweb3-cn-client.htm
```

然后，把：

```Lisp
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
```
改为：

```Lisp
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242
                                  :document-root "www/"))
```

这样 Hunchentoot 就会使用当前目录下的 "www/" 文件夹作为根目录了。

重新加载代码，然后访问：[http://localhost:4242/lispweb3-cn-client.htm](http://localhost:4242/lispweb3-cn-client.htm)，客户端便出来啦～

建议：出于性能考虑，不建议使用 Hunchentoot 托管静态文件。你可以试试用 [Nginx](https://www.nginx.com/) 做个 [代理](https://www.nginx.com/resources/admin-guide/reverse-proxy/)，然后把 Hunchentoot 仅仅作为一个应用服务器使用。

### 结束之前

必须要坦白几件事情啊。为了方便讲解，在一些使用方法和操作习惯上我骗了同学们，这里一一忏悔：

* 日常开发中，很少出现 `sbcl --load xxx.lisp` 这种情况，大多是直接在 REPL 里敲代码，这样可以直接触摸到所有的数据和状态。

* 日常开发中，几乎没有人用 `sbcl` 作为 REPL，它太难用了，上下左右不行，还没有历史记录。你应该试试 [SLIME](https://www.common-lisp.net/project/slime/)，相比之下，就是神器。

对了，还有：

如果你想用 Lisp 的方式去畅游 Lisp 之海，墙裂建议你使用 [Emacs](https://www.gnu.org/software/emacs/)，那就是您的尚方宝剑啊包龙星大人！

### 引用

感谢这两篇文章：

* [Lisp for the Web](http://www.adamtornhill.com/articles/lispweb.htm) by Adam Tornhill, April 2008

* [Lisp for the Web, Part II](http://msnyder.info/posts/2011/07/lisp-for-the-web-part-ii/) by Matthew Snyder, July 2011

给了我很大启发。

谢谢观看。

**脚注：**

<a id="fn1">[1]</a> Hunchentoot **不是**当下最好的选择：

> **不要再直接使用 Hunchentoot 。** 选择 [Clack](http://clacklisp.org/)，或者更好的一个基于 Clack 的框架。

\- [2015年 Common Lisp 生态现状](http://eudoxia.me/article/common-lisp-sotu-2015/)

~~(2015/11 修订：在试用了一段时间 Clack 之后，我并不喜欢它，详细查看这里 https://gist.github.com/c41e1940ab0a3135dc6c)~~

(2016/08 修订：Clack 并没有那么差劲，我去年有些傻，这篇文章也有些傻)

---
版权：**禁止转载，禁止演绎，作者保留一切权利**  (已授权转载单位：杭州又拍云科技有限公司)

V2EX 讨论：[http://v2ex.com/t/215726](http://v2ex.com/t/215726)

本文已集结成书：[Lisp 与现代Web开发](https://selfstore.io/products/446)，你可以从 [SelfStore](https://selfstore.io/products/446) 上购买。
