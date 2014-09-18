#' Sling messages and warnings with flair
#'
#' @importFrom jsonlite fromJSON
#' @importFrom fortunes fortune
#' @export
#'
#' @param what (character) What do you want to say? See details.
#' @param by (character) Type of thing, one of cow, chicken, poop, cat, facecat, bigcat, longcat, 
#' shortcat, behindcat, longtailcat, anxiouscat, ant, pumpkin, ghost, spider, rabbit, pig, snowman, 
#' frog, hypnotoad, signbunny, stretchycat, or  fish. We use \code{match.arg()} internally, so you 
#' can use unique parts of words that don't conflict with others, like "g" for "ghost" because 
#' there's no other animal that starts with "g".
#' @param type (character) One of message (default), warning, or string (returns string)
#' @param length (integer) Length of longcat. Ignored if other animals used.
#'
#' @details You can put in any phrase you like, OR you can type in one of a few special phrases
#' that do particular things. They are:
#'
#' \itemize{
#'  \item catfact A random cat fact from http://catfacts-api.appspot.com/doc.html
#'  \item iheart A random quote from http://iheartquotes.com/api
#'  \item fortune A random quote from an R coder, from fortunes library
#'  \item time Print the current time
#' }
#'
#' Note that if you choose \code{by='hypnotoad'} the quote is forced to be, as you could imagine,
#' 'All Glory to the HYPNO TOAD!'. For reference see \url{http://knowyourmeme.com/memes/hypnotoad}.
#'
#' @examples
#' say()
#' say("what")
#' say('time')
#' say('time', "poop")
#' say("who you callin chicken", "chicken")
#' say("ain't that some shit", "poop")
#' say("icanhazpdf?", "cat")
#' say("yeppers", "anxiouscat")
#' say("boo!", "pumpkin")
#' say("hot diggity", "frog")
#' say("fortune", "spider")
#' say("fortune", "facecat")
#' say("fortune", "stretchycat")
#' say("fortune", "behindcat")
#'
#' # Vary type of output, default calls message()
#' say("hell no!")
#' say("hell no!", type="warning")
#' say("hell no!", type="string")
#'
#' # Using fortunes
#' say(what="fortune")
#'
#' # Using catfacts
#' say("catfact", "cat")
#'
#' # Using iheartquotes
#' say("iheart", "chicken")
#'
#' # The hypnotoad
#' say(by="hypnotoad")
#'
#' # The longcat, from BoingBoing
#' say("it's caturday!", "longcat")
#' say("i'm so short", "longcat", length=0) # AKA - shortcat
#' say("that's better", "longcat", length=6)
#'
#' # Fish
#' say(by='fish')
#'
#' # Bunny holding a sign
#' say(by='signbunny')

say <- function(what="Hello world!", by="cat", type="message", length=18)
{
  if(!length==0){
    body <- paste(rep('    |    |\n', length), collapse = "")
    body <- gsub('\n$', '', body)
    longcat <- sprintf(longcat, "%s", body)
  } else { longcat <- shortcat }

  by <- match.arg(by, choices=c("cow", "chicken", "poop", "cat", "facecat", "ant",
      "pumpkin", "ghost", "spider", "rabbit", "pig", "snowman", "frog",
      "hypnotoad","longcat","shortcat","bigcat","behindcat","stretchycat","anxiouscat",
      "longtailcat","fish", "signbunny"))
  if(what=="time")
    what <- as.character(Sys.time())
  if(what=="fortune") {
    what <- fortune(sample(1:316,1))
    what <- paste(as.character(what), collapse="\n ")
  }
  if(what=="catfact"){
    what <- jsonlite::fromJSON('http://catfacts-api.appspot.com/api/facts?number=1')$facts
    by <- 'cat'
  }
  if(what=="iheart"){
    tmp <- jsonlite::fromJSON('http://www.iheartquotes.com/api/v1/random?format=json')$quote
    tmp <- gsub("\t|\n|\r", "", tmp)
    what <- gsub('\"', "'", tmp)
  }
  if(by=="hypnotoad"){
    what <- "All Glory to the HYPNO TOAD!"
  }
  switch(type,
         message = message(sprintf(get(by), what)),
         warning = warning(sprintf(get(by), what)),
         string = sprintf(get(by), what))
}