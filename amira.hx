# Amira Script
remove -all
remove cell.nii vessel.nii Isosurface Isosurface2 BoundingBox2

# Create viewers
viewer setVertical 0

viewer 0 setBackgroundMode 1
viewer 0 setBackgroundColor 0.06 0.13 0.24
viewer 0 setBackgroundColor2 0.72 0.72 0.78
viewer 0 setTransparencyType 5
viewer 0 setAutoRedraw 0
viewer 0 show
mainWindow show

set hideNewModules 0
[ load -nifti ${SCRIPTDIR}/cell.nii ] setLabel cell.nii
cell.nii setIconPosition 22 39
cell.nii setTransform 1 0 0 0 0 1 0 0 0 0 1 0 1 1 1 1
cell.nii fire
cell.nii setViewerMask 16383

set hideNewModules 0
[ load -nifti ${SCRIPTDIR}/vessel.nii ] setLabel vessel.nii
vessel.nii setIconPosition 14 120
vessel.nii setTransform 1 0 0 0 0 1 0 0 0 0 1 0 1 1 1 1
vessel.nii fire
vessel.nii setViewerMask 16383

set hideNewModules 0
create HxIsosurface {Isosurface}
Isosurface setIconPosition 160 126
Isosurface data connect vessel.nii
Isosurface colormap setDefaultColor 0.76 0.4 1
Isosurface colormap setDefaultAlpha 0.500000
Isosurface colormap setLocalRange 0
Isosurface fire
Isosurface drawStyle setValue 1
Isosurface fire
Isosurface drawStyle setSpecularLighting 1
Isosurface drawStyle setTexture 0
Isosurface drawStyle setAlphaMode 1
Isosurface drawStyle setNormalBinding 1
Isosurface drawStyle setSortingMode 1
Isosurface drawStyle setLineWidth 0.000000
Isosurface drawStyle setOutlineColor 0 0 0.2
Isosurface textureWrap setIndex 0 1
Isosurface cullingMode setValue 0
Isosurface threshold setMinMax 0 1
Isosurface threshold setButtons 0
Isosurface threshold setIncrement 0.1
Isosurface threshold setValue 0
Isosurface threshold setSubMinMax 0 1
Isosurface options setValue 0 1
Isosurface options setToggleVisible 0 1
Isosurface options setValue 1 0
Isosurface options setToggleVisible 1 1
Isosurface resolution setMinMax 0 -2147483648 2147483648
Isosurface resolution setValue 0 2
Isosurface resolution setMinMax 1 -2147483648 2147483648
Isosurface resolution setValue 1 2
Isosurface resolution setMinMax 2 -2147483648 2147483648
Isosurface resolution setValue 2 2
Isosurface numberOfCores setMinMax 1 10
Isosurface numberOfCores setButtons 1
Isosurface numberOfCores setIncrement 1
Isosurface numberOfCores setValue 8
Isosurface numberOfCores setSubMinMax 1 10
{Isosurface} doIt hit
Isosurface fire
Isosurface setViewerMask 16383
Isosurface setShadowStyle 0
Isosurface setPickable 1

set hideNewModules 0
create HxIsosurface {Isosurface2}
Isosurface2 setIconPosition 148 23
Isosurface2 data connect cell.nii
Isosurface2 colormap setDefaultColor 1 0.8 0.4
Isosurface2 colormap setDefaultAlpha 0.500000
Isosurface2 colormap setLocalRange 0
Isosurface2 fire
Isosurface2 drawStyle setValue 1
Isosurface2 fire
Isosurface2 drawStyle setSpecularLighting 1
Isosurface2 drawStyle setTexture 0
Isosurface2 drawStyle setAlphaMode 1
Isosurface2 drawStyle setNormalBinding 1
Isosurface2 drawStyle setSortingMode 1
Isosurface2 drawStyle setLineWidth 0.000000
Isosurface2 drawStyle setOutlineColor 0 0 0.2
Isosurface2 textureWrap setIndex 0 1
Isosurface2 cullingMode setValue 0
Isosurface2 threshold setMinMax 0 1
Isosurface2 threshold setButtons 0
Isosurface2 threshold setIncrement 0.1
Isosurface2 threshold setValue 0.357542
Isosurface2 threshold setSubMinMax 0 1
Isosurface2 options setValue 0 1
Isosurface2 options setToggleVisible 0 1
Isosurface2 options setValue 1 0
Isosurface2 options setToggleVisible 1 1
Isosurface2 resolution setMinMax 0 -2147483648 2147483648
Isosurface2 resolution setValue 0 2
Isosurface2 resolution setMinMax 1 -2147483648 2147483648
Isosurface2 resolution setValue 1 2
Isosurface2 resolution setMinMax 2 -2147483648 2147483648
Isosurface2 resolution setValue 2 2
Isosurface2 numberOfCores setMinMax 1 10
Isosurface2 numberOfCores setButtons 1
Isosurface2 numberOfCores setIncrement 1
Isosurface2 numberOfCores setValue 8
Isosurface2 numberOfCores setSubMinMax 1 10
{Isosurface2} doIt hit
Isosurface2 fire
Isosurface2 setViewerMask 16382
Isosurface2 select
Isosurface2 setShadowStyle 0
Isosurface2 setPickable 1

set hideNewModules 0
create HxBoundingBox {BoundingBox2}
BoundingBox2 setIconPosition 151 70
BoundingBox2 data connect cell.nii
BoundingBox2 fire
BoundingBox2 options setState item 0 0 color 1 1 0.5 0 item 3 0 
BoundingBox2 lineWidth setMinMax 1 10
BoundingBox2 lineWidth setButtons 0
BoundingBox2 lineWidth setIncrement 1
BoundingBox2 lineWidth setValue 1
BoundingBox2 lineWidth setSubMinMax 1 10
BoundingBox2 font setState name: {Helvetica} size: 12 bold: 0 italic: 0 color: 0.8 0.8 0.8
BoundingBox2 fire
BoundingBox2 setViewerMask 16383
BoundingBox2 setShadowStyle 0
BoundingBox2 setPickable 1

set hideNewModules 0


viewer 0 setCameraOrientation 0.0742 0.019616 0.99705 1.53699
viewer 0 setCameraPosition 316.438 602.653 1590.88
viewer 0 setCameraFocalDistance 1335.79
viewer 0 setCameraNearDistance 1381.1
viewer 0 setCameraFarDistance 1653.84
viewer 0 setCameraType perspective
viewer 0 setCameraHeightAngle 44.9023
viewer 0 setAutoRedraw 1
viewer 0 redraw

