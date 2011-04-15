#!/bin/sh
# This shell script simply copies the built plug-in to "~/Library/Graphics/Quartz Composer Plug-Ins" and overrides any previous version at that location

mkdir -p "$USER_LIBRARY_DIR/Graphics/Quartz Composer Plug-Ins"
rm -rf "$USER_LIBRARY_DIR/Graphics/Quartz Composer Plug-Ins/CunddStreamServer.plugin"
cp -rf "$BUILT_PRODUCTS_DIR/CunddStreamServer.plugin" "$USER_LIBRARY_DIR/Graphics/Quartz Composer Plug-Ins/"

