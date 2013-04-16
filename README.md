Sgt Donowitz
=================================

What?:
------
It's a git pre-commit script that checks your Javascript code for errors before every commit, if it finds any issues it simply aborts the commit.


Why?:
-----
Because it's easier to maintain good code when you are forced to


How?:
-----
from the root of your project run:

`curl -s jt.io/lint | sh`


Where?
------
Mac OS X / Unix only


But... What if?
--------
If for some reason you must commit a JS file without validating/linting it you can always run a commit with the "no-verify" flag:
i.e. `git commit --no-verify .`  

However, when doing this remember that there are no flags to remove bad Karma.


More?
------
If you want to learn more about this, I've written a blog post in my blog [here](http://jt.io/2013/git-pre-commit-js-lint-script/)
