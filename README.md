#Instacode for Vim

You just wrote the perfect code and want to immortalize it forever. Who wants to disrupt their workflow to put it on [instacode](http://instacod.es/)? Now, posting to instacode is as simple as a visual select.

##Install

Requires vim compiled with `+python` (sorry, but i didn't feel like writing a url encoding function)

Install with [Pathogen](https://github.com/tpope/vim-pathogen), or whatever floats your boat.

##Usage

In visual selection mode, just type `<Leader>ic` (if you haven't changed it, `<Leader>` is probably `\`)

In normal mode, `:Instacode` will use the last thing you visually selected.
