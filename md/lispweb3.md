# Lisp for The Modern Web

August 2015

> Lisp isn't a language, it's a building material.

\-  Alan Kay

### What to Expect

This piece is about how to build a modern web application with Common Lisp in the backend, from scratch.

You may need to have some knowledge about web developments to proceed, such as: HTML / CSS / JavaScript / ... etc, and some other related concepts.

### Why Lisp? Again

**It is awesome**.

I don't think we need another reason for using Lisp, do we? Life is short, let's be awesome!

It's been more than half a century since Lisp first appeared, she's like the [The One Ring](https://en.wikipedia.org/wiki/One_Ring) in the Middle-earth. The one who mastered the spell of Lisp, will rule the world, once again.

**Other reasons**.

If you need some other reasons beside awesome, here is some [quotes](http://www.paulgraham.com/quotes.html) and [articles](http://www.paulgraham.com/lisp.html) about Lisp, enjoy them.

### Let's Talk about Business

What to do?

We are going to "build a modern web application with Commin Lisp in the backend", as mentioned before.

In recent days, many people build web applications with a **`Server with JSON output`** and a **`Client with HTML5 + JavaScript`**. And we will do it the same way.

As you have had some web development skills, we'll focus on the server part, and the client part will not be explained in detail.

### The Steps

* [Hello Lisp!](#hello-lisp)
* [Hello World!](#hello-world)
* [Let's Be JSON](#lets-be-json)
* [Storing Data to Disk](#storing-data-to-disk)

#### Hello, Lisp!

We assume that you have no knowledge about Lisp, so let's say hello:

* Go to [sbcl.org](http://sbcl.org/), and open the [Download](http://sbcl.org/platform-table.html) page, choose your platform and download your binary.

* Then follow [this instruction](http://sbcl.org/getting.html) to install and run it.

* Ok, now you have a [REPL](http://www.cliki.net/REPL)!


    >This is SBCL 1.2.7, an implementation of ANSI Common Lisp.

    >More information about SBCL is available at <http://www.sbcl.org/>.

    >

    >SBCL is free software, provided as is, with absolutely no warranty.

    >It is mostly in the public domain; some portions are provided under

    >BSD-style licenses.  See the CREDITS and COPYING files in the

    >distribution for more information.

    >\* 


* Type `(format t "Hello, Lisp!")`, then hit <kbd>Enter</kbd>

    >\* (format t "Hello, Lisp!")

    >**Hello, Lisp!**

    >NIL

    >\* 

* Now, you have learned Lisp!

"You must be kidding!!", yes. Now let's do something more complicated:

* Open a file, paste codes below, then save it as `say-hello.lisp`:

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

First, when we type `(format t "Hello, Lisp!")`, we called a function which name is `format`, and passed two arguments: `t` and `"Hello, Lisp!"`. Well then, what is function `format` about?

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

inside. Well, we know that `(format t "Hello, ~a" to)` means replace directive `~a` with the value of variable `to`, and then print them out to the standard output. But, what does `(defun say-hello (to)` mean?

Let's try google: [_common lisp defun_](https://www.google.com/search?q=common+lisp+defun).

Well, we got this: [CLHS: Macro DEFUN](http://www.lispworks.com/documentation/lw50/CLHS/Body/m_defun.htm) and this: [Functions](http://www.gigamonkeys.com/book/functions.html).

After read them, we know that `defun` is a Macro which is used to create funcion. The first argument of `defun` is the function name, and the second argument of `defun` is the arguments of the function, and typically, the rest will be the body of the function.

So, it means we just created a function name by `say-hello` and takes one argument `to`. When the function is called, it concatenate the value of variable `to` with string `"Hello, "`, then print them to the standard output. This could be the JavaScript version:

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

* Go to [quicklisp.org](http://quicklisp.org), follow the [installation guide](https://www.quicklisp.org/beta/#installation)(yes, the paragraph with the dark background, copy and paste and execute all the bold lines in your terminal), install it.

* Open a file, paste codes below, then save it as `server.lisp`:

    ```Lisp
    (ql:quickload :hunchentoot)
    (hunchentoot:start (make-instance 'hunchentoot:easy-acceptor :port 4242))
    ```

* Open a terminal, and change to current directory

* Type `sbcl --load server.lisp`, hit <kbd>Enter</kbd>

* After loading, use your favourite browser to open this link: [http://localhost:4242/](http://localhost:4242/)

* YOU JUST CREATED A WEBSITE WITH LISP!

* YOU ARE AWESOME!!!


Ok, calm down, let's do something to make people know that it's _YOU_ who created a website with lisp. Add below codes to your `server.lisp` file:

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

Second, we should thank [Edi Weitz](http://weitz.de/), he/she is an extremely awesome and fascinating Lisper on this planet. You will meet so many Lisp projects under Edi Weitz's magic hands after surfing a while in the Lisp world, and then you will be subdued by the charm of the codes. Ok, after the words of praise, we just used [Hunchentoot](http://weitz.de/hunchentoot/) as the server, it's well documented, you will love it.

#### Let's Be JSON

Yes yes, I know I know. The HTML5 + JavaScript client likes JSON, the front team won't be happy if we give them plain text response.

So, how to do it in Common Lisp?

* Open a file, paste codes below, then save it as `json-server.lisp`:

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

#### Storing Data to Disk

For now, we've made a **`Server with JSON output`**. But, we never store anything.

So, let's store every instance of people which is created when [http://localhost:4242/you?name=Jack](http://localhost:4242/you?name=Jack) is requested.
