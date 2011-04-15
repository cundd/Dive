#!/bin/sh
ls /Users/${USER}/Sites/mac_iPhone_dev/a_training/Dive/build/Release/${PRODUCT_NAME}.framework/
rm -R /Users/${USER}/Library/Frameworks/${PRODUCT_NAME}.framework
cp -Rf /Users/${USER}/Sites/mac_iPhone_dev/a_training/Dive/build/Release/${PRODUCT_NAME}.framework/ /Users/${USER}/Library/Frameworks/${PRODUCT_NAME}.framework
