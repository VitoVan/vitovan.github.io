# Web Spider: Converting Website to JSON, Without Coding

September 2015

#### 1) You must have written a web spider

Me, too. I love my first web spider, it is written in Java and can do the Daily Signin for me at company, so I can be late for work without the management knows. It works like charm until the day my boss show up in my office (while I am in bed).

#### 2) You must have written your second web spider

Me, too. I wrote my second web spider to follow a girl's music play-history (on a music website), and will download then play the same last track once her play-history changed.

[It](https://github.com/VitoVan/LoveOnXiami) is written in Python, and it also works like charm until the day I feel sick about the music it plays for me.

#### 3) You must have written your third web spider

Me, too. I wrote my third web spider in 10 hours, it even has a GUI. [It](http://whereisjob.com/) grabs data from a [forum](http://v2ex.com/go/jobs), then convert it to JSON, and then show it on a map.

It's funny, and works like charm. But seems no one need it, even myself.

#### 4) You must realized something

Me, too. It's not very hard to write a spider, but it costs your time, and may endup with useless.

You have to choose a programing language, then choose your library (http-request or dom-parse or something else), then start writing.

Then debug and test and the sun is going down, stop it.

#### 5) Eenough talk, show me the solution

I created a project called [cl-spider](https://github.com/VitoVan/cl-spider). It provides some some functions (2 for now), and takes **URI** and **CSS SELECTORS** and **HTML ATTRIBUTES** as arguments, then return the data you want. Such as:

```Lisp
(cl-spider:get-data "https://news.ycombinator.com/" :selector "a" :attrs '("href" "text"))
```

![](https://raw.githubusercontent.com/VitoVan/cl-spider/master/screenshots/get-data.png)

> "Ok, man, stop it. Yet Another Web Spider? And I do not use Lisp."

\- Jack Pythonking

> "It is useless. Where is JSON?"

\- Rose Javener

#### 6) Well, the real solution

Since so few people using Common Lisp today, I created another project called [such-cute](https://github.com/VitoVan/such-cute), It is the Web Interface of [cl-spider](https://github.com/VitoVan/cl-spider).

By using [such-cute](https://github.com/VitoVan/such-cute), you can avoid writing any Lisp code and just visit a link then you have your JSON:

[http://localhost:5000/get?uri=https://news.ycombinator.com/&selector=a&attrs=["href","text"]](http://localhost:5000/get?uri=https://news.ycombinator.com/&selector=a&attrs=["href","text"])

![](https://raw.githubusercontent.com/VitoVan/such-cute/master/screenshots/json.png)

All you have to do is: Have a Common Lisp environment and run the such-cute server.

> "No no no no no, I won't touch Common Lisp."

\- Rayman Phiper

> "This is ridiculous! I still have to config the Common Lisp environment?"

\- Gustav Bosser

> "Oh! Forget it! Still suck."

\- Semon Manager

#### 7) OK, Forget What I have said

Just visit the link:

[http://sc.vitovan.com/get?uri=https://news.ycombinator.com/&selector=a&attrs=["href","text"]](http://sc.vitovan.com/get?uri=https://news.ycombinator.com/&selector=a&attrs=["href","text"])

And check this: [http://sc.vitovan.com/](http://sc.vitovan.com/)
