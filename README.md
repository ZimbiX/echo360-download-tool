Echo360 Download Tool
=====================

Usage: `ruby echo360-download-tool.rb RSS_URL`

[Download now](https://github.com/ZimbiX/echo360-download-tool/archive/master.zip)

This is a small program intended to help download video recordings of university lectures from Echo360. To use, supply the URL of the RSS feed of the Echo360 page from which you'd like to download all the videos, and this program will:

* Output a comma-separated list of video names and links
* Save a HTML file with a list of links to the video files
* Open the HTML file in Firefox
	+ You can then use DownThemAll! with renaming mask: `*text*.*ext*`

You could just use DownThemAll! by itself from the RSS page, but you won't have meaningful filenames as Echo360 names all the video files 'media.m4v'

Note:

* You will need to have Ruby to run this program. Installing Ruby is pretty easy; see: https://www.ruby-lang.org/en/installation
* The RSS feed URL can be found at the very bottom of the course's Echo360 page. Hover over the icon and click 'Vodcast'. Copy the URL from this page, and remove the 's' from 'https', if present.
* DownThemAll! is an excellent Firefox addon for accelerating downloads, which can be installed from: http://www.downthemall.net
* To use DownThemAll!, just right-click in an empty space in the page, and select DownThemAll! to interactively download all the linked files on a page. Choose where to download the videos to, set the renaming mask to: `*text*.*ext*`, then click Start!
* If you want to run this again to download only new videos, set the destination in DownThemAll! to that which contains the first set of videos, and when it starts, will prompt you what to do -- just choose to automatically skip all existing files for the current session