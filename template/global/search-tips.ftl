<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
  <title>Jive SBS Search Tips</title>


    
  <style type="text/css">
body {
margin: 0px; padding: 0px;
font-family: Lucida Grande, Arial, Helvetica, sans-serif;
font-size: 9pt;
background-color: #fff;
color: #333;
}
.header {
border-bottom : 1px #ccc solid;
}
.title {
font-family : arial;
font-size : 14pt;
font-weight : bold;
}
.close A, .close A:visited {
font-family : verdana, arial, helvetica, sans-serif;
font-size : 8pt;
white-space : nowrap;
color : #00f;
}
.nav, .nav A {
font-family : verdana;
font-size : 8pt;
}
.nav A, .nav A:visited {
color : #00f;
text-decoration : underline;
}
.nav A:hover {
color : #00f;
text-decoration : none;
}
h2 {
font-size: 11pt;
margin: 18px 0px 5px 0px;
padding: 0px;
}
h3 {
font-size: 10pt;
margin: 18px 0px 5px 0px;
padding: 0px;
}
TT {
font-size : 10pt;
font-family : courier new, monospace;
font-weight : bold;
color : #333;
}
blockquote {
border : 1px #ccc solid;
-moz-border-radius : 2px;
padding : 3px;
margin-left : 5%;
margin-right : 25%;
background-color : #eee;
}
#highlightbox {
border : 1px #ccc solid;
-moz-border-radius : 2px;
padding : 10px;
margin-top: 20px;
//margin-left : 5%;
//margin-right : 25%;
    background-color: #e8f1f8;
    }
#pageContainer {
display: block;
position: relative;
clear: both;
background-color: #fff;
border: 1px solid #999;
padding: 40px;
margin: 30px;
-moz-border-radius: 6px;
}
  </style>
</head>


  <body class="jive-body-help jive-body-searchtips">

<div id="pageContainer">
<div class="header">
<table border="0" cellpadding="0" cellspacing="0" width="100%">

  <tbody>

    <tr>

      <td class="title" width="99%"> Search Tips </td>

      <td class="close" width="1%"> <a href="#" onclick="window.close();return false;">Close Window</a>
      </td>

    </tr>

  </tbody>
</table>

</div>

<!-- ======================================================================= -->
<div id="highlightbox">
<h2>Top 3 Ways to Make Your Search More Accurate</h2>
<p>Most of the time, you just want to find content that has a particular phrase. Here are the three easiest steps to get what you want:</p>
  <ol>
    <li><b>Enclose your search phrase in quotes.</b> 
      <p>A search for <tt>"black cat"</tt> is going to return content with the phrase "black cat". (If it's in there, of course.)</p></li>
    <li><b>Choose the space where the content lives.</b> 
      <p>Choose a value from the "where" dropdown list. When you pick a space from the list, your search will return results <i>only</i> from that space.</p></li>
    <li><b>Choose the time period during which the content you're looking for was last changed.</b> 
      <p>Choose a value from the "when" dropdown list. Was it within the last month? Last year?</p></li>
  </ol>

</div>

  <h2>More Advanced Help</h2>
<p>Here are a few more tips for getting the most out of your searches.
By entering your search terms in certain ways, you can search for
content that contains:</p>
<ul>
  
<li> <a href="#basic">Certain words, but not
necessarily all of the words in order.</a> </li>

<li> <a href="#phrase">Certain words in a certain
order.</a> </li>

<li> <a href="#wildcard">Words with certain letters
in them.</a> </li>

<li> <a href="#fuzzy">Terms that are pretty close to
the one you enter.</a> </li>

<li> <a href="#proximity">Certain words near each
other.</a> </li>

<li> <a href="#boolean"><tt>this</tt>
word OR <tt>that</tt> word; <tt>this</tt>
word AND <tt>that</tt> word.</a> </li>
</ul>
  
<p>You can <a href="#exclude"><span style="font-style: italic;">exclude</span> certain
words.</a> </p>
<p>You can also:</p>
  <ul>
  
<li> <a href="#boosting">Boost content with certain
words upwards in the results list.</a> </li>

<li> <a href="#escaping">Include special characters
in your search phrase.</a> </li>
    
  </ul>
  
<h2><a name="basic"></a>Search for content
that has certain words, but not necessarily all of the words in order.</h2>

<p>This is the most basic search. Simply enter your search terms.
For example:</p>

<blockquote> <tt>black cat adoption</tt> </blockquote>

<p>This will search for documents containing the words <tt>black</tt>,
<tt>cat</tt> and <tt>adoption</tt>.</p>

<h2><a name="phrase"></a>Search for content
that has certain words in a certain order.</h2>

<p>To search for a particular phrase, enclose your phrase in
quotation marks:</p>

<blockquote> <tt>"black cat"</tt> </blockquote>

<p>Search will try to find content with those words in the order
you enclosed them. It will also find other content that merely contains
those words.</p>

<!-- ======================================================================= -->
<h2><a name="wildcard"></a>Search for content
with words that have certain letters in them.</h2>

<p></p>

<p>Use "wildcards" to search parts of words. Wildcards are
special characters you include in your search terms. These include <tt>?</tt>
and <tt>*</tt>.</p>

<p>The single character wildcard (<tt>?</tt>)
represents a single character in the search term. This search looks for
terms that match with the single character replaced. For example, to
search for <tt>text</tt> or <tt>test</tt> you
can use the following search:</p>

<blockquote> <tt>te?t</tt> </blockquote>

<p>The multiple character wildcard (<tt>*</tt>)
represents any number of characters. For example, to search for <tt>test</tt>,<tt>tests</tt>
or <tt>tester</tt>, you can use the search:</p>

<blockquote> <tt>test*</tt> </blockquote>

<p>You can also use this wildcard in the middle of a term.</p>

<blockquote> <tt>te*t</tt> </blockquote>

<p><b>Note:</b> You cannot use a <tt>*</tt>
or <tt>?</tt> symbol as the first character of a search.</p>

<!-- ======================================================================= -->
<h2><a name="fuzzy"></a>Search for content
with terms that are pretty close to the one you enter.</h2>

<p>"Fuzzy" searches return results that match your search terms
exactly as well as results that are close. For example, if you want to
find a word that is similar to <tt>foam</tt> add a tilde (<tt>~</tt>)
to your search term:</p>

<blockquote> <tt>foam~</tt> </blockquote>

<p>This search will match terms like <tt>foam</tt>
and <tt>roams</tt>.</p>

<!-- ======================================================================= -->
<h2><a name="proximity"></a>Search for content
in which certain words are near each other.</h2>

<p>Proximity searches help you find words that are close to each
other. For example, if you know the word <tt>new</tt> and <tt>car</tt>
are within five words of each other you can enter a search phrase like
this:</p>

<blockquote> <tt>"new car"~5</tt> </blockquote>

<!-- ======================================================================= -->
<h2><a name="boosting"></a>Boost content with
certain words upwards in the results list.</h2>

<p>Boosting a search term gives it more weight in the results
list. For example, if you search for <tt>black cat</tt>
you might get results about black paint and cats but not necessarily
black cats. In this case, we want to tell the search engine to weight
the word "cat" more heavily: </p>

<blockquote> <tt>black cat^4</tt> </blockquote>

<p>You can also boost phrases:</p>

<blockquote> <tt>"black cat"^4 adopt</tt> </blockquote>

<p>You can use any number to boost the term -- the higher the
number, the higher the boosting. For example, if the query above still
returns too many results, consider increasing the boost value:</p>

<blockquote> <tt>"black cat"^6 adopt</tt> </blockquote>

<!-- ======================================================================= -->
<h2><a name="boolean"></a>Search for content
with <tt>this</tt> word OR <tt>that</tt>
word; <tt>this</tt> word AND <tt>that</tt>
word.</h2>

<p>With Boolean operators, you can combine terms. The words <tt>AND</tt>,<tt>+</tt>,
<tt>OR</tt>, <tt>NOT</tt> and <tt>-</tt>
are supported. Note, these terms must be in ALL CAPS to distinguish
them from normal words.</p>

<h3>Using OR</h3>

<p> The <tt>OR</tt> operator links two terms and
finds a matching document if either of the terms exist in a document.
Note, the symbol <tt>||</tt> can be used in place of the
word <tt>OR</tt>. To search for documents that contain
either "black cat" or just "cat adoption" use the query:</p>

<blockquote> <tt>"black cat" OR "cat adoption"</tt> </blockquote>

<p>or</p>

<blockquote> <tt>"black cat" || "cat adoption"</tt> </blockquote>

<p><b>Note:</b> <tt>OR</tt> is the
default way to put search terms together, even if you leave it out. So
the following search is equivalent to both of the previous examples:</p>

<blockquote> <tt>"black cat" "cat adoption"</tt> </blockquote>

<h3>Using AND</h3>

<p>The <tt>AND</tt> operator says that the search
should return content in which all of the search terms are present.
Note, the symbol <tt>&amp;&amp;</tt> can be used
in place of the word <tt>AND</tt>. To search for documents
that contain <i>both</i> "black cat" <i>and</i>
just "cat adoption" use a search like this:</p>

<blockquote> <tt>"black cat" AND "cat adoption"</tt>
</blockquote>

<p>or this:</p>

<blockquote> <tt>"black cat" &amp;&amp; "cat
adoption"</tt> </blockquote>

<p>You can get fancy by grouping Boolean phrases using
parentheses. For example, to find results about different colors of
cats, try the following: </p>

<blockquote> <tt>(black OR orange OR white) AND cat</tt>
</blockquote>

<h3><a name="exclude"></a>Search for content
that <i>doesn't</i> have certain words.</h3>

<p>The <tt>NOT</tt> operator excludes documents that
contain terms after <tt>NOT</tt>. You can use the <tt>!</tt>
symbol in place of the word <tt>NOT</tt>. To search for
documents that contain "black cat" but not "cat adoption" use something
like this:</p>

<blockquote> <tt>"black cat" NOT "cat adoption"</tt>
</blockquote>

<p>or</p>

<blockquote> <tt>"black cat" ! "cat adoption"</tt> </blockquote>

<p><b>Note:</b> The NOT operator must be used with
multiple terms. For example, the following search will return no
results:</p>

<blockquote> <tt>NOT "black cat"</tt> </blockquote>

<!--
<h3>Searching for content that absolutely has to contain certain words.</h3>
<p> The <tt>+</tt> operator tells the search engine that the search term must appear in a
document to be a match. To search for documents that must contain "black cat" and may
contain "cat adoption" use the query:</p>
<blockquote>
<tt>+"black cat" "cat adoption"</tt>
</blockquote>
<h3>The "-" Keyword</h3>
<p>The <tt>-</tt> operator excludes documents that contain the term after the "-" symbol. To
search for documents that contain "black cat" but not "cat adoption" use the query:</p>
<blockquote>
<tt>"black cat" -"cat adoption"</tt>
</blockquote>
-->
<!-- ======================================================================= -->
<h2><a name="escaping"></a>Include special
characters in your search phrase.</h2>

<p>There are a few special characters that you can't include in a
search phrase without special treatment. That's because these are part
of the query syntax. However, you can use a special "escape" character
to tell the search engine to treat the special character like any other.</p>

<p>The current list special characters includes:</p>

<blockquote> <tt>+ - &amp;&amp; || ! ( ) { } [ ] ^
" ~ * ? : \</tt> </blockquote>

<p>To escape these characters use the <tt>\</tt>
before the character. For example, to search for <tt>(1+1):2</tt>,
which has the special characters <tt>(</tt>, <tt>)</tt>,<tt>+</tt>,
and <tt>:</tt>, use the query:</p>

<blockquote> <tt>\(1\+1\)\:2</tt> </blockquote>

</div>

</body>
</html>
