<!--0-->
# Lisp for The Modern Web

2015/08, revision: 2015/08, 2015/09, 2016/08

> Lisp isn't a language, it's a building material.

\-  Alan Kay

### What to Expect

This piece is about how to build a modern web application with Common Lisp in the backend, from scratch.

You may need to have some knowledge about [Front End Development](https://en.wikipedia.org/wiki/Front_end_development), cause we won't explain the steps for building the client.

### Why Lisp? Again

**It is awesome**.

I don't think we need another reason for using Lisp, do we? Life is short, let's be awesome!

It's been more than half a century since Lisp first appeared, she's like the [The One Ring](https://en.wikipedia.org/wiki/One_Ring) in the Middle-earth. The one who mastered the spell of Lisp, will rule the world, once again.

**Other reasons**.

If you need some other reasons beside awesome, here is some [quotes](http://www.paulgraham.com/quotes.html) and [articles](http://www.paulgraham.com/lisp.html) about Lisp, enjoy them.

### Let's Do It

Do what?

We are going to "build a modern web application with Common Lisp in the backend", as mentioned before.

In recent days, many people build web applications with a **`Server with JSON output`** and a **`Client with HTML5 + JavaScript`**. And we will do it the same way.

As you have had some Front End Development skills, we'll focus on the server part, and the client part will be provide as source code for you.

### The Steps

* [Hello Lisp!](#hello-lisp)
* [Hello World!](#hello-world)
* [Let's Be JSON](#lets-be-json)
* [Data Storage](#data-storage)
* [Modern Client](#modern-client)

#### Hello, Lisp!

We assume that you have no knowledge about Lisp, so let's say hello:

* Go to [sbcl.org](http://sbcl.org/), and open the [Download](http://sbcl.org/platform-table.html) page, choose your platform and download your binary.

* Then follow [this instruction](http://sbcl.org/getting.html) to install and run it.

* OK, now you have a [REPL](http://www.cliki.net/REPL)!


>This is SBCL 1.2.7, an implementation of ANSI Common Lisp.

>More information about SBCL is available at <http://www.sbcl.org/>.

>

>SBCL is free software, provided as is, with absolutely no warranty.

>It is mostly in the public domain; some portions are provided under

>BSD-style licenses.  See the CREDITS and COPYING files in the

>distribution for more information.

>\*


Before we start coding, let's talk about the basic grammar in Lisp. Many people say "It's weird!", but it is also the charming part.

You can imagine Lisp grammar like [Pac Man](http://www.webpacman.com/pacman.php) eating the dots: `ᗧ••••`, and there is no ghosts here. Pac Man is the function in Lisp, and the dots are arguments. After Pac Man eat up all the dots (the function is executed with all these arguments), it becames a dot: `•` . and a dot is able to be eaten by another Pac Man.

So, you can imagine a Lisp program like this:

```Lisp
;;Day 1, we created Pac Men and dots
(ᗧ• (ᗧ••••
 (ᗧ••
 (ᗧ•••))))
;;Day 2, The innermost Pac Man eat up all the dots in front of him/her
;;and, turns into a dot 
(ᗧ• (ᗧ••••
 (ᗧ••
 •)))
;;Day 3, Eating is not stopping
(ᗧ• (ᗧ••••
•))
;;Day 4, The last Pac Man
(ᗧ• •)
;;Day 5, Finally, Pac Man is just another dot
•
```

Yes, they are just Pac Man and dots! When there is multiple Pac Men and dots, the innermost Pac Man will eat first, then it turns into a dot, waiting to be eaten by other Pac Man. It's funny, isn't it?

Now, let's get back to REPL:


* Type `(format t "Hello, Lisp!")`, then hit <kbd>Enter</kbd>

>\* (format t "Hello, Lisp!")

>**Hello, Lisp!**

>NIL

>\* 

* Now, you have learned Lisp!

"YOU MUST BE KIDDING!!", yes. Now let's do something more complicated:

* Open a file, paste code below, then save it as `say-hello.lisp`:

```Lisp
(defun say-hello (to)
 (format t "Hello, ~a" to))
```

* Open a terminal, and change to current directory

* Type `sbcl --load say-hello.lisp`, hit <kbd>Enter</kbd>

>[vito@laptop lispweb3]$ sbcl --load say-hello.lisp

>This is SBCL 1.2.7, an implementation of ANSI Common Lisp.

>More information about SBCL is available at <http://www.sbcl.org/>.

>

>SBCL is free software, provided as is, with absolutely no warranty.

>It is mostly in the public domain; some portions are provided under

>BSD-style licenses.  See the CREDITS and COPYING files in the

>distribution for more information.

>\*

* Then you'll get the REPL with the file loaded. Type `(say-hello "Vito")`, hit <kbd>Enter</kbd>

>\* (say-hello "Vito")

>Hello, Vito

>NIL

>\*

* Now, you see, you are saying hello to me with Lisp!

**Ok, what we've done?**

First, when we type `(format t "Hello, Lisp!")`, we called a function which name is `format`, and passed with two arguments: `t` and `"Hello, Lisp!"`. Well then, what is function `format` about?

Here is the document: [CLHS: Function FORMAT](http://www.lispworks.com/documentation/lw50/CLHS/Body/f_format.htm), and here is [A Few FORMAT Recipes](http://www.gigamonkeys.com/book/a-few-format-recipes.html). Typically, we can google it by these keywords: [_common lisp format_](https://www.google.com/search?q=common+lisp+format), thank google, we'll always get the answer.

>......

>format destination control-string &rest args => result

>Arguments and Values:

>**destination---nil, t, a stream, or a string with a fill pointer.**

>**control-string---a format control.**

>args---format arguments for control-string.

>result---if destination is non-nil, then nil; otherwise, a string.

>......

\- [CLHS: Function FORMAT](http://www.lispworks.com/documentation/lw50/CLHS/Body/f_format.htm)

>...... the destination for the output, can be T, NIL, a stream, or a string with a fill pointer. **T is shorthand for the stream *STANDARD-OUTPUT***, while NIL causes  ......

>...... The second argument, the control string, is, in essence, a program in the FORMAT language. ...... Most of FORMAT's directives ......

>FORMAT Directives

>......

\- [A Few FORMAT Recipes](http://www.gigamonkeys.com/book/a-few-format-recipes.html)

Now we know that the first argument of `(format t "Hello, Lisp!")` is destination, when we pass it `t`, it means `*STANDARD-OUTPUT*`. We also know that the second argument of `(format t "Hello, Lisp!")` is control-string, which just like a template, without directives, it is just a string.

So, `(format t "Hello, Lisp!")` means print string `"Hello, Lisp!"` to the standard output, then return `nil` (you can assume that `t` means `true` and `nil` means `false` in Lisp, for now).

Second, we wrote a file with:

```Lisp
(defun say-hello (to)
 (format t "Hello, ~a" to))
```

Well, we know that `(format t "Hello, ~a" to)` means replace directive `~a` with the value of variable `to`, and then print them out to the standard output. But, what does `(defun say-hello (to)` mean?

Let's try google: [_common lisp defun_](https://www.google.com/search?q=common+lisp+defun).

Well, we got this: [CLHS: Macro DEFUN](http://www.lispworks.com/documentation/lw50/CLHS/Body/m_defun.htm) and this: [Functions](http://www.gigamonkeys.com/book/functions.html).

After read them, we know that `defun` is a Macro which is used to create funcion. The first argument of `defun` is the function name, and the second argument of `defun` is the arguments of the function, and typically, the rest will be the body of the function.

So, it means we just created a function named by `say-hello` and takes one argument `to`. When the function is called, it concatenate the value of variable `to` with string `"Hello, "`, then print them to the standard output. This could be the JavaScript version:

```JavaScript
//It seems there is no string format function in JavaScript, so...
function sayHello(to){
    console.log("Hello, ~a".replace("~a",to));
}
```

#### Hello World!

Now, you have learned how to program in Common Lisp, but nobody knows except you and me, it's not good.

So, let's say hello to the world.

>If I have seen further, it is by standing on the shoulders of giants.

\- Isaac Newton

Let's meet the giants:

* Go to [quicklisp.org](http://quicklisp.org), follow the [installation guide](https://www.quicklisp.org/beta/#installation) (yes, the paragraph with the dark background, copy and paste and execute all the bold lines in your terminal), install it.

* Open a file, paste code below, then save it as `server.lisp`:

```Lisp
(ql:quickload :hunchentoot)
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
```

* Open a terminal, and change to current directory

* Type `sbcl --load server.lisp`, hit <kbd>Enter</kbd>

* After loading, use your favourite browser to open this link: [http://localhost:4242/](http://localhost:4242/)

* YOU JUST CREATED A WEBSITE WITH LISP!

* YOU ARE AWESOME!!!


Ok, calm down, let's do something to make people know that it's _YOU_ who created a website with Lisp. Add the code below to your `server.lisp` file:

```Lisp
 ;;remeber to change Vito to your name.
(hunchentoot:define-easy-handler (say-hello :uri "/hello") (name)
 (setf (hunchentoot:content-type*) "text/plain")
 (format nil "Hello, ~a! I am Vito! ~%I build a website with Lisp!!!" name))
```

* then click <kbd>Ctrl</kbd> + <kbd>d</kbd> or type `(quit)` then hit <kbd>Enter</kbd> to quit current REPL.

* In the terminal, Type `sbcl --load server.lisp`, hit <kbd>Enter</kbd> , again.

* After loading, check here: [http://localhost:4242/hello?name=World](http://localhost:4242/hello?name=World)

* YES, **_YOU_** just said hello to the world! WITH **_LISP_** !

**What we've done?**

It's not so hard to understand, isn't it?

First, we should thank Quicklisp, it is a library manager for Common Lisp, and it has [over 1,200 libraries](https://www.quicklisp.org/beta/releases.html), after install it, you can ride a bike with NO HANDS!

Second, we should thank [Edi Weitz](http://weitz.de/), he/she is an extremely awesome and fascinating Lisper on this planet. You will meet so many Lisp projects under Edi Weitz's magic hands after surfing a while in the Lisp world, and then you will be subdued by the charm of the code. Ok, after the words of praise, we just used [Hunchentoot](http://weitz.de/hunchentoot/) [\[1\]](#fn1) as the server, it's well documented, you will love it.

We just load [Hunchentoot](http://weitz.de/hunchentoot/) with Quicklisp, like this: `(ql:quickload :hunchentoot)`, and then start the Hunchentoot Server on port 4242: `(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))`. At last, we defined a HTTP handler with Hunchentoot's [define-easy-handler](http://weitz.de/hunchentoot/#define-easy-handler).

For further usage about Hunchentoot, you'll find them in the [document](http://weitz.de/hunchentoot).

#### Let's Be JSON

Yes yes, I know I know. The Front Team won't be happy if we give them plain text response, they all like [JSON](http://json.org/).

So, how to do it in Common Lisp?

* Open a file, paste code below, then save it as `json-server.lisp`:

```Lisp
(ql:quickload '(hunchentoot cl-json))
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
;;Create a class called people.
;;What? CLASS!!??
;;Yes, it is a class. Lisp is not just a Functional Programming Language.
;;Remember? it's a building material!!
(defclass people()
  ((name :accessor name
         :initarg :name)
   (language :accessor language
             :initarg :language)
   (bio :accessor bio
        :initarg :bio)))
;;Make a people.
(defvar me
  (make-instance 'people
                 :name "Vito Van"
                 :language "Lisp"
                 :bio "I have no job, I'm dying. Someone hire me, I can eat."))
;;Send me to the world, in JSON.
(hunchentoot:define-easy-handler (say-me :uri "/me") ()
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string me))
;;Dynamic build a people, and response back in JSON.
(hunchentoot:define-easy-handler (say-you :uri "/you") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (make-instance
    'people
    :name name
    :language "English"
    :bio (format nil "I am ~a's colon. I get cancer, I kill ~a. " name name))))
```

* Quit all the other REPLs, then load the file `sbcl --load json-server.lisp`!

* Check here: [http://localhost:4242/me](http://localhost:4242/me), and here: [http://localhost:4242/you?name=Jack](http://localhost:4242/you?name=Jack)

Yes, you have done it! Look ma, it's JSON!

For now, I don't think you need explains in detail anymore. We just created a class, made some instance of it, and encoded it to JSON, then send back to the browser. Here are documents about `defclass` and `cl-json`:

* [CLHS: Macro DEFCLASS](http://clhs.lisp.se/Body/m_defcla.htm) and [Object Reorientation: Classes](http://www.gigamonkeys.com/book/object-reorientation-classes.html)

* [CL-JSON](https://common-lisp.net/project/cl-json/)

#### Data Storage

Where we are now?

We've made a **`Server with JSON output`**, it's a big deal. But, we never store any data yet. So, let's give him/her a shot who ever visit [http://localhost:4242/you?name=Jack](http://localhost:4242/you?name=Jack).

Here is the original code for that request:

```Lisp
;;Dynamic build a people, and response back in JSON.
(hunchentoot:define-easy-handler (say-you :uri "/you") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (make-instance
    'people
    :name name
    :language "English"
    :bio (format nil "I am ~a's colon. I get cancer, I kill ~a. " name name))))
```

We could let's make it better:

```Lisp
;;Store the people instance
(defun store-people (people)
  (ᗧ• people •)
  people)
;;Make a people instance by name
(defun make-people (name)
  (make-instance
   'people
   :name name
   :language "English"
   :bio (format nil "I am ~a's colon. I get cancer, I kill ~a. " name name)))
;;Dynamic build a people, and response back in JSON.
(hunchentoot:define-easy-handler (say-you :uri "/you") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (store-people
    (make-people name))))
```
We just added a function `make-people`, it makes the code concise. And we know that Pac Man in the code won't really work, let's fix it.

What's the common sence for storing data? Database Products, yes. But we won't use database today, because:

* It's not cool, everybody is using it.

* It's complicated, we have to learn how to use a Database Product.

* I have the data in the memory, why not just make it AS IS?

So, we could do it like this:

```Lisp
(defvar *people-list* nil)
;;Store the people instance
(defun store-people (people)
  (push people *people-list*)
  people)
```

Yes! We just store the people in the variable `*people-list*`! How to send the people list to browser?

```Lisp
(hunchentoot:define-easy-handler (people :uri "/people") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   *people-list*))
```

Here is the minimal part to test out memory storage:

```Lisp
(ql:quickload '(hunchentoot cl-json))
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
;;Create a class called people.
(defclass people()
  ((name :accessor name
         :initarg :name)
   (language :accessor language
             :initarg :language)
   (bio :accessor bio
        :initarg :bio)))
;;Define a list
(defvar *people-list* nil)
;;Store the people instance
(defun store-people (people)
  (push people *people-list*)
  people)
;;Make a people instance by name
(defun make-people (name)
  (make-instance
   'people
   :name name
   :language "English"
   :bio (format nil "I am ~a's colon. I get cancer, I kill ~a. " name name)))
;;Dynamic build a people, and response back in JSON.
(hunchentoot:define-easy-handler (say-you :uri "/you") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (store-people
    (make-people name))))
(hunchentoot:define-easy-handler (people :uri "/people") ()
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   *people-list*))
```

You can save the code above to file `storage-server.lisp`, and then loaded with `sbcl --load storage-server.lisp` (remember to quit all the other REPLs to avoid port number conflicts).

Then click these links first: [Jack](http://localhost:4242/you?name=Jack), [Tyler](http://localhost:4242/you?name=Tyler), [Marla](http://localhost:4242/you?name=Marla).

And then check here to see if they are stored: [http://localhost:4242/people](http://localhost:4242/people).

What happend? It just works.

**What? You wanna store them into the disk?**

Since we decide not to use a Database Product, then how to store the data to the disk and restore them easily? Let's try [OBJECT PREVALENCE](http://hillside.net/sugarloafplop/papers/5.pdf), it means we are going to take a snapshot on current memory and save it as a file, then restore them anytime.

Of course we can build our own implementation, but thank to [Sven Van Caekenberghe](http://www.cliki.net/Sven Van Caekenberghe), we can use [CL-PREVALENCE](https://common-lisp.net/project/cl-prevalence/). It's not very well documented as [Hunchentoot](http://weitz.de/hunchentoot/), but we have the [API](https://common-lisp.net/project/cl-prevalence/CL-PREVALENCE.html) and the source code, do we?

* First, add `cl-prevalence` to your quicklisp load list:

```Lisp
(ql:quickload '(hunchentoot cl-json cl-prevalence))
```

* Then initialize your prevalence system (we should define the class first for prevalence system to use):

```Lisp
;;We add "id" to the people class, the prevalence system will need it.
(defclass people()
  ((id :reader id
       :initarg :id)
   (name :accessor name
         :initarg :name)
   (language :accessor language
             :initarg :language)
   (bio :accessor bio
        :initarg :bio)))
;;Init the system
(defvar *p-system* (cl-prevalence:make-prevalence-system #p"./p-system/"))
;;Create counter if not exists
(or (> (length (cl-prevalence:find-all-objects *p-system* 'people)) 0)
	(cl-prevalence:tx-create-id-counter *p-system*))
```

* Modify the original function `make-people`

```Lisp
(defun make-people (name)
  (cl-prevalence:tx-create-object
   *p-system*
   'people
   `((name ,name)
     (language ,"English")
     (bio ,(format nil "I am ~a's colon. I get cancer, I kill ~a. " name name)))))
```
* Delete function `store-people` and varible `*people-list*`, because the data is automatically stored into the prevalence system when we call `make-people`.

* Modify our controllers

```Lisp
;;Dynamic build a people, and response back in JSON.
(hunchentoot:define-easy-handler (say-you :uri "/you") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (make-people name)))
;;Get all the people in our prevalence system
(hunchentoot:define-easy-handler (people :uri "/people") ()
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (cl-prevalence:find-all-objects *p-system* 'people)))
```

* And finally, we got this

```Lisp
(ql:quickload '(hunchentoot cl-json cl-prevalence))
;;Create a class called people.
(defclass people()
  ((id :reader id
       :initarg :id)
   (name :accessor name
         :initarg :name)
   (language :accessor language
             :initarg :language)
   (bio :accessor bio
        :initarg :bio)))
;;Init the system
(defvar *p-system* (cl-prevalence:make-prevalence-system #p"./p-system/"))
;;Create counter if not exists
(or (> (length (cl-prevalence:find-all-objects *p-system* 'people)) 0)
    (cl-prevalence:tx-create-id-counter *p-system*))
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
;;Make and sotre a people instance by name
(defun make-people (name)
  (cl-prevalence:tx-create-object
   *p-system*
   'people
   `((name ,name)
     (language ,"English")
     (bio ,(format nil "I am ~a's colon. I get cancer, I kill ~a. " name name)))))
;;Dynamic build a people, and response back in JSON.
(hunchentoot:define-easy-handler (say-you :uri "/you") (name)
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (make-people name)))
;;Get all the people in our prevalence system
(hunchentoot:define-easy-handler (people :uri "/people") ()
  (setf (hunchentoot:content-type*) "application/json")
  (json:encode-json-to-string
   (cl-prevalence:find-all-objects *p-system* 'people)))
```

* Save the code above to file `p-storage-server.lisp`, and then loaded with `sbcl --load p-storage-server.lisp` (remember to quit all the other REPLs to avoid port number conflicts).


Then click these links first: [Robert Paulson](http://localhost:4242/you?name=Robert Paulson), [Tyler](http://localhost:4242/you?name=Tyler), [Jack](http://localhost:4242/you?name=Jack), [Lou](http://localhost:4242/you?name=Lou).

And then check here to see if they are stored: [http://localhost:4242/people](http://localhost:4242/people).

What happend? It just works as the `*people-list*`.

**To witness the miracle**

Now, type `(cl-prevalence:snapshot *p-system*)` in your REPL, hit <kbd>Enter</kbd>.

Then, quit all your REPLs and close all the tabs in your browser (except this one).

Reload your code: `sbcl --load p-storage-server.lisp`, then review the page: [http://localhost:4242/people](http://localhost:4242/people).

Do you see Tyler? The CL-PREVALENCE automatically loaded the snapshot for us, we don't even noticed.

#### Modern Client

I've create a single file as client, you can [download](lispweb3/lispweb3-client.htm) and modify it, it's just the mix of HTML / JavaScript and CSS.

**Then what's left?**

We need to serve this file, let's check the [document of Hunchentoot](http://weitz.de/hunchentoot/#start). Here we can see:

>...... The location of the document root directory can be specified when creating a new ACCEPTOR instance by the way of the ACCEPTOR-DOCUMENT-ROOT. . ......

\- [Hunchentoot](http://weitz.de/hunchentoot/)

So what we should do is just create a directory called `www` in the same level of `p-storage-server.lisp`, and then get the HTM file into it:

```Lisp
wget -P www http://vito.sdf.org/lispweb3/lispweb3-client.htm
```

Then change:

```Lisp
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
```
To this:

```Lisp
(hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242
                                  :document-root "www/"))
```

Then Hunchentoot will use the "www/" in current folder as root directory, now try to reload our code.

Then visit: [http://localhost:4242/lispweb3-client.htm](http://localhost:4242/lispweb3-client.htm), you got what you want.

Suggestion: You do not really wanna use Hunchentoot to serve your static files, do you? You should try [Nginx](https://www.nginx.com/) as a [PROXY](https://www.nginx.com/resources/admin-guide/reverse-proxy/), and make your Hunchentoot as an application server only.

### Before the End

I have to say that I lied to you about the way we do when coding in Common Lisp for convenience of explanation.

* We do not usually load file like this `sbcl --load xxx.lisp`. We directly type and eval in the REPL, that's the charming part of Lisp.

* We do not usually directly type and eval in the REPL created by `sbcl`, it hurts. You should try [SLIME](https://www.common-lisp.net/project/slime/), it makes life much more easier.

And, one more thing:

If you wanna surfing in the Lisp world in Lisp-way, [Emacs](https://www.gnu.org/software/emacs/) is your laser sword, my young Jedi.

### References

Thanks to:

* [Lisp for the Web](http://www.adamtornhill.com/articles/lispweb.htm) by Adam Tornhill, April 2008

* [Lisp for the Web, Part II](http://msnyder.info/posts/2011/07/lisp-for-the-web-part-ii/) by Matthew Snyder, July 2011

I wish this piece of work could be:

* [Lisp for the Web, Part III](http://vito.sdf.org/lispweb3.html) by Vito Van, August 2015

That would be a great honor to me.

Thanks for reading.

**Footnotes:**

<a id="fn1">[1]</a> Hunchentoot is **NOT** a good choice for now:

> **Stop using Hunchentoot directly.** Use Clack, or even better, one of the frameworks built on it.

\- [State of the Common Lisp Ecosystem, 2015 ](http://eudoxia.me/article/common-lisp-sotu-2015/)

~~( 2015/09 revision: After playing around Clack, I do not like it, check this https://gist.github.com/c41e1940ab0a3135dc6c)~~

(2016/08 revision: Clack is not so bad, I was just being stupid last year, and this article is... kind of stupid)

---

License: GNU GPL v2.0

Discuss on HN: [https://news.ycombinator.com/item?id=10102549](https://news.ycombinator.com/item?id=10102549)

This piece of work has been updated as the book [Lisp for the Modern Web](https://www.gitbook.com/book/vitovan/lispweb3), you can buy it from [GitBook](https://www.gitbook.com/book/vitovan/lispweb3/details).
