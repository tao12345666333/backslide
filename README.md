# :sweat_drops: backslide

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Build Status](https://travis-ci.org/tao12345666333/backslide.svg?branch=master)](https://travis-ci.org/tao12345666333/backslide)
[![pipeline status](https://gitlab.com/taobeier/backslide/badges/master/pipeline.svg)](https://gitlab.com/taobeier/backslide/commits/master)
[![Docker Build Status](https://img.shields.io/docker/build/taobeier/backslide.svg)](https://hub.docker.com/r/taobeier/backslide/)

## screenshot

![screenshot.png](https://raw.githubusercontent.com/tao12345666333/backslide/master/screenshot.png)


# What is backslide

> CLI tool for making HTML presentations with [Remark.js](https://github.com/gnab/remark) using [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).
> This project is "dockerized" [backslide](https://github.com/sinedied/backslide). Thanks @sinedied.

## Features

- Template generator with [Sass](http://sass-lang.com) styling
- Live preview server
- Self-contained HTML export
- Automated PDF conversion
- Multiple presentations support

# How to use this image

If we want to save files on our host, we can mount directory to `/src` by using `-v` to `docker run`.

## Creating a new presentation

If you want to create a new presentation in the `$HOME/backslide` directory, you can run `init` by using the backslide Docker image directly:

```
sudo docker run --rm -v $HOME/backslide:/src taobeier/backslide init
```

This command will create a new presentation along with a template directory in the current directory. The template directory is needed for backslide to transform your Markdown files into HTML presentations.

Then edit the file `presentation.md` to get started.

You can create as many markdown presentations as you want in the directory, they will all be based on the same template.

If you want to start a new presentation using your own custom template, you can use `sudo docker run -v $HOME/backslide:/src -v <your_template_dir>:/template taobeier/backslide init --template /template`. You can also set the environment variable `BACKSLIDE_TEMPLATE_DIR` to change the default template used by `bs init`, just pass `-e BACKSLIDE_TEMPLATE_DIR` to docker run.


### Making your slides

If you want to making your slides, you can run `serve` by using the backslide Docker image directly:

```
sudo docker run --rm --init -p 4100:4100 -v $HOME/backslide:/src taobeier/backslide serve -s -p 4100
```

This command will start a development server with live reload.
You can open [http://127.0.0.1:4100](http://127.0.0.1:4100) in your web browser, all your presentations are showing.

Select one to see the preview, you can then edit your `.md` file and see the changes immediately as you save the file. Any style change will also be applied live.

Slides are written in [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet), along with some useful **Remark.js** specific additions.
See the [Remark.js wiki](https://github.com/gnab/remark/wiki) for the specific syntax and helpers.

You can use `Ctrl C` or `docker stop` command to stop the live container.

#### Customize style

Just edit the `template/style.scss` file and make changes according to your needs.
The base theme already provides some helpful additions.

The stylesheet is written in [Sass](http://sass-lang.com), but you can use plain CSS instead if you feel like it, as long as you don't change the file extension.

### Exporting your slides as self-contained HTML

If you want to export all your `.md` files as HTML presentations, you can run `export` by using the backslide Docker image directly:

```
sudo docker run --rm -v $HOME/backslide:/src taobeier/backslide export
```

It will make a directory named `dist`. Everything will be inlined in the HTML document (scripts, css, etc) so you don't need a network to show your presentation.
If you have images, it's best to include them as [data-uri](https://css-tricks.com/data-uris/) in your markdown, but local images links are inlined too during export.

If you have set a `title` variable in your document (like this `title: My Awesome Presentation`), it will be used as the HTML document title, otherwise the file name will be used.

> Note: you can strip presenter notes from the exported HTML using the `--strip-notes` option, and remove slide fragements with the `--handouts` option.

### Known Issues

* Can't export to PDF, because we don't install chromium. I will fix it soon.
