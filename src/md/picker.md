<!--4-->
# Meditations on Color Picker

2019/06

> Caution: the text below contains coarse language.

A few months ago, there's a person who wrote a cross-platform color picker with Electron Technology, it got the huge file size and consumes a lot of resources when run.

It's more than 140 MB after unpacked on macOS (more than 230 MB on Linux), and yes you need to unpack it before use. When running, it consumes more than 100 MB RAM and nearly 20% CPU on my laptop.

### What's the Matter?

It's like you're buying one lemon from the online fruit market, ten minutes after you paid, there's a delivery person with a big fridge knocking at your door.

You opened the door, and the delivery person said: "Hi dear customer, here's your lemon, hope you enjoy!"

You looked around, then said: "So, where's the lemon?"

"It's inside the fridge, my dear!", the delivery person pointed at the fridge.

"Wow, how thoughtful you are, thank you! Get it out for me, would you?"

"Oh, don't bother, you can have the fridge, it's all yours!"

"But, I already have a fridge in my kitchen, I just want the lemon."

"Uh, I see. You can get this fridge into your kitchen, power it up, and then press this red button. Voilà! You will get what you want!"

"OK, it sounds like magic. But, can we just open the fridge NOW and get the lemon out for me? I mean, you can have the fridge if you like 'cause I just need the lemon."

"I'm sorry, my dear customer, I can't do that", the delivery person frowned and continued: "the fridge won't open until you power it up and press the button, it has to be done like that. It's for the good of lemon. By that way, you can have the freshest lemon when you need."

"OK, I get it, so I have to move this fridge into my kitchen and power it up, to get the lemon, am I right?"

"I'm afraid so, my dear customer, but I can help you with that."

"OK, thank you, please", then the delivery person starts moving the big fridge which contains one lemon into your kitchen.

After 30 minutes, the delivery person came out and told you it's all set. Then you go to the kitchen and pressed the red button on the fridge.

Start with a short beep, a sweet and pleasant human voice said: "Hi, my name is Refi, your smart fridge. I'm sorry I can't open the door for you because of the lack of free space. Please move me to another place which has at least 2 x 2 meters free, and then press the red button again. Thank you for your understanding."

...

"My dear customer, with all my respect, I have to say, what a small kitchen you have!"

### What the Fuck?

So, what the fuck is going on?

Are we really going to ship a fucking single lemon with a whole fucking giant fridge?

I felt pissed off.

I felt sorrow and confused.

It's like the day Oracle bought Sun; like the day Apple chose flat design over skeuomorphic; like the first time I upgraded my desktop environment to GNOME 3; like the day my favorite Linux distro decided to use systemd; like the day Linus Torvalds said sorry and accepted the Code of Conduct ...

It felt like all things are fucked up and keep rotting.

Now Node.js carrying gigabytes node_modules and Docker carrying thousands of images and Electron bundling the whole fucking Chrome are taking the world.

So, What the fuck exactly is going on here?

After long deep sorrow for a few months, one thought came up to me:

Maybe, it's just me, I am getting old.

### Why the Fuck?

As time goes by, I found myself speaking more and more "What the fuck!" instead of "This is awesome!", it feels like I am growing to a whining arrogant old human, who knows nothing and stick on the fragile worthless experience, and sees everything as a piece of shit when they do not fit the good old experience.

I've learned too much.

I admired the KISS principle which UNIX taught me, and one day someone came out with systemd and tell me it's the feature, and they even use binary log files over raw text streams. How can I accept that?

I was once so fascinated by the flawless skeuomorphic design Apple brought us, and they suddenly switched everything into flat design! Fucking flat design! It's a blessing for Steve Jobs not seeing this!

I must stop now, or I will complain about these things for a whole fucking day.

As a human, when growing up, I accumulate what I learned every day, it's good and makes it easier to learn new things, 'cause I got a better understanding about the whole world and how it works and can see things from the bigger picture. But, that's not all.

There's one obstacle for a grown-up human, it's called "Too much wisdom". "Too much wisdom" means too many opinions are treated as the unshakable truth, that causes ignorance and pain. Actually, there's no such thing as unshakable truth, and if there is, the only unshakable truth is every truth is shaking constantly.

The world is changing, so does the truth. If I was born to this world recently, there's no way for Electron to piss me off, maybe I'll be fascinated by it and do a lot of things to improve it. It's not right or wrong, they're all reasonable, as Hegel [once said](https://en.wikiquote.org/wiki/Georg_Wilhelm_Friedrich_Hegel#Elements_of_the_Philosophy_of_Right_(1820/1821)).

After realized that, I stopped blame systemd or flat design, upgraded my OS with the most recent Linux distro and bought myself an iPad. They're not that bad.

And, I felt peace and calm.

### What's Next?

Since I stopped complaining, there left a lot of free time for me to think and do things.

So, why not build a cross-platform color picker which consumes less resource? Something not Electron but also can get the job done? It must be fun!

Then I went through some cross-platform solutions in the good old days, Lisp and Tk seem like a good combination. And after a while of digging down and piling up, voilà! here's the awesome **Cross-Platform Color Picker Written in Common Lisp**!

![Color Picker Running on macOS](picker/osx.png)

It runs on Linux / macOS / Windows, and less than 20 MB on all platform, consumes more than 100 MB RAM and nearly 30% CPU on my laptop.

If using Electron means shipping one lemon with a whole fridge, then what I've done here means shipping one lemon with a smaller box filled with ice. So, it's **NOT THAT GOOD** when competing with Electron. But we're not competing, it's fun to do something different, right?

You can download the color picker from [here](https://github.com/VitoVan/cl-pkr#downloads), and the source code is also [available](https://github.com/VitoVan/cl-pkr), if you're interested.

### Further More

If you experienced the color picker above and interested in writing applications with the same technology, I wrapped something as [cl-icebox](https://github.com/VitoVan/cl-icebox) to help you to achieve that.

Have fun and prosper 🖖 !

---

Discuss on reddit: https://redd.it/c8g36d
