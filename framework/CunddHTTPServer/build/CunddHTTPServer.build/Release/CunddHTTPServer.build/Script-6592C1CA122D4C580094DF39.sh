#!/bin/sh
ls ${BUILD_DIR}/Release/${PRODUCT_NAME}.framework/

rm -R /Users/${USER}/Library/Frameworks/${PRODUCT_NAME}.framework
cp -Rf ${BUILD_DIR}/Release/${PRODUCT_NAME}.framework /Users/${USER}/Library/Frameworks/${PRODUCT_NAME}.framework

