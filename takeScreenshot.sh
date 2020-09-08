#!/bin/sh

screenshot_name="screenshot_$(date | grep -o -E "[0-9]{2}:[0-9]{2}:[0-9]{2}").png"

import -window root ~/$screenshot_name
