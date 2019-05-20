#!/bin/sh
# Purpose: Geographic location of the cross-sectonal profiles of the Mariana Trench
# GMT modules: grdcut, grdinfo, grdcontour, psbasemap, psxy, pstext, logo
# Step-1. Generate a file
ps=GMT_JB_profiles_MT.ps
# Step-2. Cut off the grid
gmt grdcut earth_relief_05m.grd -R120/160/0/35 -Gmt_relief.nc -V
gmt grdinfo @mt_relief.nc
# Step-3. Add contour
gmt grdcontour @mt_relief.nc -R120/160/0/35 -JB140/15/10/20/6.0i \
    -C1000 -A2000+f7p,Helvetica,dimgray -S4 -T+d15p/3p \
	--MAP_GRID_PEN_PRIMARY=thinnest \
	-P -K > $ps
# Step-4. Basemap: title, ticks
gmt psbasemap -R -J \
	--FORMAT_GEO_MAP=dddF \
	--MAP_FRAME_PEN=dimgray \
	--MAP_FRAME_WIDTH=0.08c \
	--MAP_TICK_PEN_PRIMARY=thinner,dimgray \
    --MAP_TITLE_OFFSET=25p \
	--FONT_TITLE=14p,Palatino-Roman,black \
    --FONT_ANNOT_PRIMARY=7p,Helvetica,darkblue \
    --FONT_LABEL=7p,Helvetica,black \
	-Bxg4f2a5 -Byg4f2a4 \
	-B+t"Geographic location of the cross-sectonal profiles of the Mariana Trench" \
    -UBL/-15p/-40p  -O -K >> $ps
# Step-5. Add profiles
gmt psxy -R -J -Sv0.15i+bc+ec -Gyellow -W0.5p -O -K << EOF >> $ps
140.0 21.5 45 3c
140.3 21.2 40 3c
140.7 20.9 35 3c
141.0 20.6 30 3c
141.3 20.3 25 3c
141.5 20.0 20 3c
141.7 19.7 17 3c
141.9 19.4 15 3c
142.1 19.1 12 3c
142.2 18.8 10 3c
142.3 18.5 5 3c
142.4 18.3 2 3c
142.3 18.0 1 3c
142.2 17.7 0 3c
142.1 17.4 -2 3c
142.0 17.1 -5 3c
141.8 16.8 -7 3c
141.6 16.5 -10 3c
141.4 16.2 -15 3c
141.2 15.9 -20 3c
140.9 15.6 -25 3c
140.6 15.3 -30 3c
140.4 15.0 -35 3c
140.2 14.7 -40 3c
140.0 14.5 -45 3c
EOF
# Step-6. Add scale, directional rose
gmt psbasemap -R -J \
    --FONT=8p,Palatino-Roman,dimgray \
    -Tdg125.2/31+w0.5c+f2+l \
    -Lx5.1i/-0.5i+c50+w1000k+l"Conic equal-area Albers projection"+f \
    -O -K >> $ps
# Step-7. Add subtitle
gmt pstext -R -J -X0.0c -Y0.0c -N -O -K \
    -F+f10p,Palatino-Roman,black+jLB >> $ps << EOF
124.0 38.0 Bathymetry: ETOPO1 Global Relief Model 1 arc min resolution grid
EOF
# Step-8. Study area
gmt psbasemap -R -J \
    -D138/6/153/28r -F+pthin,red \
    -O -K >> $ps
# Step-9. Study area label annotation
gmt psxy -R -J -Wthick -O -K \
-Sqn1:+f10p,Times-Roman,red+l"Study Area"+c4p+gwhite+pthick,red+o << EOF >> $ps
138 7.0
151 6.8
EOF
# Step-10. Add logo
gmt logo -R -J -Dx6.5/-2.2+o0.1i/0.1i+w2c -O -K >> $ps
# Step-11. Add caption
gmt pstext -R0/10/0/15 -JX10/10 -X1.0c -Y-2.5c -F+f7p,Helvetica,dimgray+jLB -N -O -K >> $ps << EOF
10.0 1.0 Scale at 15\232N, km
EOF
gmt pstext -R0/10/0/15 -JX10/10 -X0.5c -Y0.0c -F+f7p,Helvetica,dimgray+jLB -N -O >> $ps << FIN
9.5 0.5 Standard paralles at 10\232 and 20\232 N
FIN
