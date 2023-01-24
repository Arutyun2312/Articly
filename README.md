# Articly

Loads articles for user to read. Articles are cached and encrypted whenever they are fetched, so that user always has something to read.

If app has no articles cached and encounters error during fetch, user will see alert. Otherwise error is not shown, when there is something to read.

User can press an article to fully read it on a new screen. In that new screen, user can go back to list by swiping; can copy author's email (press & hold) and open mail app, where author would be the recipient. If picture doesn't load for some reason, then user will see "retry" button to reload. Pictures are stored in memory, to avoid redownloads.
