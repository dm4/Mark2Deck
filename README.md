Mark2Deck
=========

`Mark2Deck` is a tool that converts your markdown file to [deck.js](http://imakewebthings.github.com/deck.js/) html slide.

Installation
------------

    $ git clone https://github.com/dm4/Mark2Deck
    $ git submodule update --init

Usage
-----
### Run the script manually

    ./md2html.pl [markdown_file]

The script `md2html.pl` will load `template.html` and replace `<: $content :>` with the output html from your markdown file.

### Using [guard](https://github.com/guard/guard)

There is also a `Guardfile` using [guard](https://github.com/guard/guard) to monitor the change of markdown file, then automatically run the script and reload browser.

Install the following gem first:

*   [guard](https://github.com/guard/guard)
*   [guard-shell](https://github.com/hawx/guard-shell)
*   [guard-livereload](https://github.com/guard/guard-livereload)

Then run [guard](https://github.com/guard/guard)

    $ guard

[guard](https://github.com/guard/guard) will automatically run the script and reload browser when markdown file updated.

File Format
-----------
-   `SLIDE-TITLE` set the title of html
-   `SLIDE-FOOTER` set the footer of slide page
-   `SLIDE-THEME` set the theme of deck.js
-   `!!hash` to create new slide page with hash
-   `!!` at the end of markdown file
-   `- !!` to create animated list item

The basic file format is in `sample/sample.md`.
