# Echo360 Download Tool

This is a set of two utilities intended to help download video recordings of university lectures from Echo360.

I created the Ruby version first, which was able to parse the class's Echo360 RSS feed. Unfortunately, it appears that the RSS feed is not always available, so I had to create a JavaScript version that manually interacts with EchoCenter to find the video links.

The basic idea is as follows:

1. Use this utility to generate a webpage with a list of named links to the video files, opened in Firefox
2. Use DownThemAll! with renaming mask `*text*.*ext*` to download the videos with the correct filenames

Note:

* DownThemAll! is an excellent Firefox addon for accelerating downloads, which can be installed from: http://www.downthemall.net
* To use DownThemAll!, just right-click in an empty space in the page, and select DownThemAll! to interactively download all the linked files on a page. Choose where to download the videos to, set the renaming mask to: `*text*.*ext*`, then click Start!
* If you want to run this again to download only new videos, set the destination in DownThemAll! to that which contains the first set of videos, and when it starts, will prompt you what to do -- just choose to automatically skip all existing files for the current session

## JavaScript version

Although there are more steps involved in using this version, it's probably the easiest to use for less-technical people.

Note:

* If you close the Echo360 page or click on a link in that tab that takes you to a new page, you'll have to start again
* The script uses virtual clicks to load content on the page. If your internet connection is slow, or you end up with some duplicate video links, try increasing the milliseconds delay value at the top of the script file. This is the delay between clicking on a video and grabbing the content of info panel

### Usage

* Open Firefox and browse to the course's **Echo360 page**
* **Right-click** in the middle of the page, and select **This Frame** -> **Show Only This Frame**
* **Right-click** in the middle of the page, and select **Inspect Element**
* In the panel that appears, click the **Console** tab at the top
* Now we need to load jQuery:
	- In a new tab, browse to: http://code.jquery.com/jquery-1.11.2.min.js
	- **Right-click** in the middle of the page, and select **Select All**
	- **Right-click** in the middle of the page, and select **Copy**
	- Return to the **Echo360** tab
	- **Right-click** in the **thin box** at the bottom, select **Paste**, then press the **Enter** key
	- The word `true` should appear at the bottom if it worked
* Now we need to run this utility script:
	- Repeat the previous instructions, but with this page: https://raw.githubusercontent.com/ZimbiX/echo360-download-tool/master/echo360-download-tool.js
* After the script has finished clicking on the videos collecting information, the page should be replaced with a list of named links to the video files
	- You can now use DownThemAll! as per the instructions in the *Notes* section above the *JavaScript version* section

## Ruby version

To use this version of the utility, you'll need to [download it](https://github.com/ZimbiX/echo360-download-tool/archive/master.zip)

Usage: `ruby echo360-download-tool.rb RSS_URL`

To use, supply the URL of the RSS feed of the Echo360 page from which you'd like to download all the videos.

You could just use DownThemAll! by itself from the RSS page, but you won't have meaningful, ordered filenames as Echo360 names all the video files 'media.m4v'

Note:

* **You will need to have Ruby to run this version**. Installing Ruby is pretty easy; see: https://www.ruby-lang.org/en/installation
* The RSS feed URL can be found at the very bottom of the course's Echo360 page. Hover over the icon and click 'Vodcast'. Copy the URL from this page, and remove the 's' from 'https', if present.