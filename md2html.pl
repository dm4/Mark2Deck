#!/usr/bin/env perl

use strict;
use File::Spec qw/abs2rel/;
use File::Basename qw/dirname basename/;
use Text::Markdown 'markdown';
use Text::Xslate 'mark_raw';
use utf8;

# get file name & file path
my $md = shift or die './md2html.pl [markdown_file]';
my $dir = dirname($md);
my $base = basename($md);
$base =~ s/\.mk?d$//;
my $relpath = File::Spec->abs2rel("./deck.js", $dir);

# get title & footer from .md
my $title = "Title";
my $footer = "Powered by SlideMD";
my $theme = "swiss";
open MDFILE, "<$md";
for (1..3) {
    my $line = <MDFILE>;
    chomp $line;
    $title = $1 if $line =~ /SLIDE-TITLE\s+(.*)$/;
    $footer = $1 if $line =~ /SLIDE-FOOTER\s+(.*)$/;
    $theme = $1 if $line =~ /SLIDE-THEME\s+(.*)$/;
}
close MDFILE;

# parse .md to .html
open MD, "<$md" or die "read error: $!";
my $markdown;
$markdown .= $_ for <MD>;
close MD;
my $raw_content = markdown($markdown);
my $content = "";
my @line = split /\n+/, $raw_content;
my $isFirst = 1;
for (@line) {
    next if /SLIDE-/;
    $_ = ($isFirst-- > 0) ? "<div class=\"slide\" id=\"$1\">" : "</div><div class=\"slide\" id=\"$1\">" if m|^<p>!!([\w+-_]+)</p>$|;
    s|^<p>!!</p>$|</div>|;
    s|^<li>(<p>)?!! (.*)$|<li class="slide">$1$2|;
    s|^<li( class="slide")?>(<p>)?#### ?(.*?)(</li>)?$|<li$1>$2<h4>$3</h4>$4|;
    s|^<li( class="slide")?>(<p>)?### ?(.*?)(</li>)?$|<li$1>$2<h3>$3</h3>$4|;
    $content .= $_."\n";
}

# generate output html from template
open OUT, ">$dir/$base.html";
binmode(OUT, ':encoding(utf8)');
my $tx = Text::Xslate->new(cache => 0);
print OUT $tx->render('template.html', {
    deckjs_path => $relpath,
    theme => $theme,
    title => $title,
    content => mark_raw($content),
    footer => $footer,
});
close OUT;
