#!/bin/bash
DIRNAME=torrents/
PID=$$
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
if [ -f badfiles.txt ]; then
    rm -f badfiles.txt
fi

echo '<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
<channel>' > rss.xml
for i in $(ls --sort=time $DIRNAME) ; do
  torrenttools magnet "$DIRNAME$i" 2>&1 | grep ^Error >/dev/null
  if [ $? -ne 0 ] ; then
  torrenttools info "$DIRNAME$i" | grep ^Name | cut -b 20- | sed 's/&/\&amp;/g' | sed 's/"/\&quot;/g' | sed "s/'/\&apos;/g" | sed 's/</\&lt;/g' | sed 's/>/&gt;/g' > $PID.info.txt
  torrenttools magnet "$DIRNAME$i" | sed 's/&/\&amp;/g' | sed 's/"/&\quot;/g' | sed "s/'/\&apos;/g" | sed 's/</\&lt;/g' | sed 's/>/\&gt;/g' > $PID.magnet.txt
  echo "<item>
<title>$(cat $PID.info.txt)</title>
<link>$(cat $PID.magnet.txt)</link>
</item>" >> rss.xml
  else
	  echo $i >> badfiles.txt
	  echo $i is bad
  fi
done
echo '</channel>
</rss>' >> rss.xml
rm $PID.info.txt
rm $PID.magnet.txt

IFS=$SAVEIFS
