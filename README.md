nugget
======

static html picture gallery generator

## Background

This project was inspired by [Panayotis Vryonis](http://blog.vrypan.net/2013/05/20/leaving-iphoto-for-dropbox/). I had a desire to move out of iPhoto and into something more future-proof and easier to maintain across machines.

I used the [export_iphoto.sh](http://blog.vrypan.net/2013/05/20/leaving-iphoto-for-dropbox/export_iphoto.sh) script to export my iPhoto library and create the directory structure nugget uses. I then created a simple static HTML generator to create one web page per year. It was determined that loading all the photos at full file size was too much, so I added a script to create thumbnails in another directory.

## Dependencies

- Ruby (last version tested: v2.1.0-rc1)
- [MiniMagick gem](https://github.com/minimagick/minimagick) - for thumbnail
creation
- ImageMagick - needed by MiniMagick gem
- jQuery (Optional; last version tested: v2.1.0; needed for zooming effect on HTML pages)

## How to Use

1. Create a file structure two folders deep for each set of pictures. See below for the recommended structure. Straying from this could cause the script not to work. At a minimum the second level folder's must have a '-' in them. If you are coming from iPhoto, the export_iphoto.sh script is a good place to start.
    ```
    /Photos  
	    /2005
		/2005-09
		    /2005-11
	    /2006
		    /2006-02
	    	/2006-04	
    ```

2. Edit the thumbs.rb file to set the source of original picture and destination folder for the thumbnails. The structure within the destination folder will be created to match the structure of the source pictures
3. Run ``ruby thumbs.rb`` command to generate thumbnails. This could take a significant amount of time depending on how many picture there are. Some tests have how that a 5000 picture library could take about 40 minutes.
4. Edit nugget.rb to set the source of the thumbnails, full size pictures and output directory.
5. Run ``ruby nugget.rb`` to generate the static files for each year of pictures
6. Browse the index.html page in the output directory to see links to the other files

## Adding Photos Later

When adding photos later, the thumbs.rb and nugget.rb scripts to be to be re-run. Thumbs.rb will only create files that don't exist, so as long as a file isn't replaced by another file in the same folder with the same name, it should generate thumbnails quickly for pictures that are added. This could be automated if you add pictures frequently enough to warrant it. nugget.rb rebuilds the entire set of HTML files, but it runs very fast to it shouldn't matter.

## Customizing

The CSS for the picture pages is very plain. Modifying any existing CSS is at your own risk, but by adding some CSS should make it easy to make the gallery pages look how you want.

## Items of Note

- Thumbnails are created at a static size of 300x225. They are cropped outward from the center of the picture so some might look weird. This was suggested by [Dave](https://github.com/dpbus) to give the pictures a more unified look.
- The thumbnails are shrunk down with CSS so that when enlarged with javascript they display without distortion

## Future Wishlist

- More file types? (.jpg, .jpeg, .png currently supported)
- dynamic pictures per row
- single config file
- handle movie files somehow