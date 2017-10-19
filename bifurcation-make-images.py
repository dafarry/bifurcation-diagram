#!/usr/bin/env pypy
from PIL import Image, ImageDraw, ImageFont
from math import ceil, exp
from numpy import array,arange,vstack,sin,pi,uint8

width,height,depth = 1200, 900, 255
padx, pady = width/20, height/25
n = 0.01
rstart,rfin = 3.0, 13.0
nmax = 3.9
astart,afin = 1.38, 1.118
stabilisemax = 1e7
ttf = "/usr/share/fonts/truetype/dejavu/DejaVuSansMono-Bold.ttf"
bold = [ ImageFont.truetype(ttf, pt) for pt in (35,25,16) ]
frames = 500

for fr in range(0,frames):
  frame = fr/(frames - 1.0)
  a =  afin + (astart - afin)*(21**(1 - frame) - 1)/20
  rmin = rstart * frame
  rmax = rmin + rfin - rstart
  surface = [0] * height * width
  for x in xrange(padx, width):
    r = (x -padx) * (rmax -rmin) / (width-padx) + rmin;
    stabilise = int(stabilisemax * (0.01 + x / width))
    for s in xrange(stabilise):
      r = (x -padx + 0.9*s/stabilise) * (rmax-rmin) / (width-padx) + rmin;
      thickline = (s % 1000) * 1e-7
      en2 = exp(-n**2)
      n = r * en2 * (a - en2) + thickline
      y = int((1 - n / nmax) * (height - pady))
      surface[x + max(0, y) * width] += 1

  light = 1.0 * depth / (depth + array(surface))
  hue = lambda h: 0.5*h[0] + 0.5*h[1] * sin(pi/2 * (light*h[2] + h[3]))
  redgreenblue = (hue((0,2,1,0)), hue((1,1,2,-1)), hue((2,2,1,-1)) ** 4)
  rgbarray=vstack(redgreenblue).T.reshape(height,width,3)
  img = Image.fromarray((rgbarray * depth).astype(uint8), mode='RGB')
  draw = ImageDraw.Draw(img)

  def axes(*coord):
    ax = array(coord) * (width - padx) / (rmax -rmin) + padx
    ax[1::2] = (1 - array(coord[1::2]) / nmax) * (height - pady)
    return ax.tolist()

  draw.line(axes(0,nmax,0,0,rmax,0), "black", 2)
  for tick in arange(0,nmax,0.5):
    draw.line(axes(0, tick, -rmax/130, tick), "black", 2)
    draw.text(axes(-rmax/28, tick +nmax/100), str(tick), "black", bold[2])
  for tick in arange(ceil(rmin),rmax,1.0):
    draw.line(axes(tick -rmin, 0, tick -rmin, -nmax/75), "black", 2)
    draw.text(axes(tick -rmin -rmax/100, -nmax/55), str(tick), "black", bold[2])

  txt = u"n \u21A6 r e   (" + '%0.3f' % a + u" - e  )"
  draw.text((width/10, height/20), txt, "black", bold[0])
  txt = u"          -n\u00B2               -n\u00B2"
  draw.text((width/10, height/21), txt, "black", bold[1])
  img.save('vid/chaos%04d.png' % fr)
