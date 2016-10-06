# Contributing to Math::GSL

Want to contribute? Great! First, read this page.

I suggest reading
[My First Pull Request](https://github.com/CPAN-PRC/resources/wiki/My-first-Pull-Request)
and [Using Pull Requests](https://help.github.com/articles/using-pull-requests/) to learn more about pull requests.

## Code reviews
All submissions, including submissions by project members, require review. 
We use Github pull requests for this purpose.

If possible, please enable Travis CI on your fork of math--gsl so that it can run on your branch. 
It tests Math::GSL across multiple versions of GSL and Perl which will find various bugs.

## Create a pull request
* Create new branch (probably from master) `git checkout -b descriptive_branch_name`  
* Fix the bug or add the feature
* Keep whatever style formatting is in the file you are editing (spaces/tabs/indentation/etc)
* Update ChangeLog that describes the change
* Add yourself to CREDITS if you are not there
* Run the tests again and make sure they pass `prove -blrv t/`
* Make sure everything you think is committed is actually committed.
* Push your changes to your fork on Github
* Submit a Pull Request (PR)
* As the PR evolves, you can keep pushing to the same branch and the PR will update with the latest commits

## Some tips for good pull requests
* Use our code
  When in doubt, try to stay true to the existing code of the project.
* Write a descriptive commit message. What problem are you solving and what
  are the consequences? Where and what did you test? Some good tips:
  [here](http://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message)
  and [here](https://www.kernel.org/doc/Documentation/SubmittingPatches).
* If your PR consists of multiple commits which are successive improvements /
  fixes to your first commit, consider squashing them into a single commit
  (`git rebase -i`) such that your PR is a single commit on top of the current
  HEAD. This make reviewing the code so much easier, and our history more
  readable.

## Formatting
This documentation is written using standard [markdown syntax](https://help.github.com/articles/markdown-basics/). Please submit your changes using the same syntax.


