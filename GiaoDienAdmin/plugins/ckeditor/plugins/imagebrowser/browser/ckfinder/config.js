/*
 Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.html or http://cksource.com/ckfinder/license
 */

var config = { language: 'vi', filebrowserImageBrowseUrl: '/ckf/ckfinder.html?type=Images', filebrowserImageUploadUrl: '/ckf/core/connector/php/connector22222.php?command=QuickUpload&type=Images' };

// Set your configuration options below.

// Examples:
// config.language = 'pl';
// config.skin = 'jquery-mobile';
config.startupPath = "Files:/Public Folder/";
config.uiModeThreshold = 38;
CKFinder.define(config);
