# Firmware Extraction #

This repo is a just a kang of available firmware extractors, at one place.

Basically, it add following commands for extracting different types of firmwares.
	
	simg2img
	
	sdat2img
	
	brotli
	
	payload

Note: This guide only guides for full firmwares, not incremental otas. If anyone knows a proper method for it, please make a pull request.

##
##
## Setup

	git clone https://github.com/Akianonymus/Firmware_Extraction --depth 1 ~/.firm_extract

	cd ~/.firm_extract

	./setup.sh

	source ~/.bashrc

Packages required:

	python2
	
	openjdk
	
	python2-pip ( required for installing python2 protobuf )
	
	protobuf ( install by pip2 install protobuf ) ( required for payload )
	
	libz-dev for ubuntu / libz-devel for fedora (required for simg2img - Install if it says zlib.h is missing ).
##
##
## Usage
Basically, the goal is to obtain a mountable image file from different file formats of firmware.

For example, to mount a image with name system.img:

	mkdir system
	sudo mount system.img system/

For further information on this, [google it](https://www.google.com/search?q=how+to+mount+img+in+linux).

I am going to cover below formats in my repo ( since formats doesn't mean much in linux, but let's assume everything is alright ).

	.dat ( sparsechunk format )

	.sparsechunk* ( usually moto split their system.img into multiple chunks )

	.dat.br ( brotli compression )

	.bin ( payload )

	.img ( sparsechunk format )

If you are unsure which format the given file is, use [file command](http://man7.org/linux/man-pages/man1/file.1.html) to check.
##
### .dat.br to .dat ###

For this conversation, google's tool brotli is used.

For example we need to convert [system|vendor].new.dat.br to [system|vendor].new.dat

	brotli --decompress -- system.new.dat.br --out system.new.dat

	brotli --decompress -- vendor.new.dat.br --out vendor.new.dat

And done.
##
### .dat to .img ( mountable format ) ###

This can be done by using [xpirt sdat2img](https://github.com/xpirt/sdat2img) tool.

For example, we need to convert system.new.dat to system.img
2 files are required: system.new.dat & system.transfer.list

	sdat2img system.transfer.list system.new.dat system.img
##
### .bin to .img ( mountable format ) ###

This is done using [payload](https://github.com/cyxx/extract_android_ota_payload) tool ( basically extracted from google repos, simplified for non-aosp environment use ) tool.

	payload payload.bin
			
Now we will obtain all the .img files in the bin. All .img files are mountable.
##
### .img ( sparsechunk ) or .sparsechunk* to .img ( mountable ) ###

The sparsechunk files maybe  splitted or single( Motorola usually does in splitted way).

So we first merge those splitted sparsechunk and convert to mountable image at the same time.

It is done using [simg2img](https://github.com/anestisb/android-simg2img) tool.

For example we have system*sparsechunk.01*,  system.*sparsechunk.02*, system.*sparsechunk.03*,  system.*sparsechunk.04* 

	simg2img  *sparsechunk* system.raw.img

Usually, the above should be last step, but in some cases, it is not mountable.

If not mountable, then do the following:

	img2raw system.raw.img system.img
	
system.img should be mountable.
##
##

## Now you have extracted your firmware, it maybe odexed ##

**For deodexing your firmware, use this tool:**
### https://github.com/Akianonymus/Android_deodexer ###
##
## Sane pull requests / suggestions / issues reports are always welcome ##
