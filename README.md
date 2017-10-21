# Bifurcation diagram

## Animation as "a" changes of n ↦ re<sup>-n<sup>2</sup></sup>(a-e<sup>-n<sup>2</sup></sup>)

**Licence: public domain**


## Files:
---

**bifurcation-make-images.py**

  This is the python script for generating the images as a sequence of
  png files in a subdirectory "vid". It is Python 2.7 compatible but
  should be run with the 2.7 compatible version of the Pypy jit-compiler
  so that it completes in ~30 minutes rather than 30 hours.
  Requires the "Pillow" fork of the "PIL" image library.
  Tested on Ubuntu -- and uses Ubuntu's location of its fonts.
  The script is dense and not very readable because it was created by
  stepwise refinement to improve visualisation of the animation.

**bifurcation-add-reverse.sh**

  Bash script to add the reversed sequence to the images, created
  from the existing images, so that the animation runs forward then
  backwards in a loop.

**bifurcation-make-vid.sh**

  Bash script to convert png image sequence to mp4 video.
  Needs the "real" ffmpeg that's in most very recent
  Linux distros but not the "fake" ffmpeg that's a front-end to
  avconv that was in many distros until just recently.

  **install-pypy-on-ubuntu.sh**

  Installing Pypy on Ubuntu proved to be a bit fiddly, so this bash
  script is provided to do it. It's advisable to read all the comments
  in the script. You might want to cut and paste each command one at a
  time to the bash shell so that you control the process.
