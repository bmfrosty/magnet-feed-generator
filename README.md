# magnet-feed-generator
This is a quick and dirty tool for generating a valid rss file out of a directory of torrent metadata files.
This relies on torrenttools.  Please have it installed and in your path.  In addition it relies on standard unix/linux tools.
Torrenttools can be found in your package manager or here - https://github.com/fbdtemme/torrenttools

# What it does!
1. Sets a directory to load torrent files from
2. Deletes badfiles.txt if it exists
3. Writes a header to rss.xml
4. Gets a list of files from the specified directory
5. Tests each file
  * If torrenttools finds the torrent file to be acceptable it
    * gets title and magnet info from the file
    * Writes an item block for that to rss.xml
  * If torrenttools finds the torrent file to be unacceptable in some manner
    * Says that the file is bad
    * writes the name of the file out to badfiles.txt
6. Writes a footer to rss.xml
7. Cleans up after itself

You may notice that it writes out (and then deletes) pid files for the data.  This is a failing on my part.

Possible future enhancements:
1. Configurable filenames (badfiles.txt and rss.xml)
2. Configurable file locations (badfiles.txt, rss.xml, and pid files)
3. Better headers and/or link sections
