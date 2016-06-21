#!/bin/bash

#######################################################################################
# Power Management Setup Script
#
# This script modifies the machine power configuration to produce more stable results.
#######################################################################################

# Must be root.
if [ `whoami` != 'root' ]
then
	echo "Must be root."
	exit 1
fi

# Install cpufrequtils.
echo "Installing cpufrequtils."
apt-get -y install cpufrequtils

# Drop the cpufrequtils config.
echo ""
echo "Writing config to /etc/default/cpufrequtils"
echo "GOVERNOR=\"performance\"" > /etc/default/cpufrequtils

# Set cpufrequtils to be called on boot.
echo ""
echo "Set cpufrequtils to be called on boot."
update-rc.d cpufrequtils enable

# Write instructions to the console on how to disable c-states.
echo ""
echo ""
echo "******** ACTION REQUIRED: C-states aren't updated via script because they require a change to kernel boot parameters. ********"
echo ""
echo "Follow these steps:"
echo "1. Edit /etc/default/grub"
echo "2. Add the following parameters to the end of GRUB_CMDLINE_LINUX_DEFAULT:"
echo "      processor.max_cstate=0 intel_idle.max_cstate=0"
echo "3. Save the file."
echo "4. Run update-grub to save changes."
echo "5. Reboot and then cat the values of"
echo "      /sys/module/intel_idle/parameters/max_cstate"
echo "      /etc/module/processor/parameters/max_cstate"
echo "   One of these files will exist and the value should be 0.  If it's not 0 then the change did not take effect."
echo ""
