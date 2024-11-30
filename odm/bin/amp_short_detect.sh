#!bin/sh
rm -f sdcard/amp.log
logcat -c
echo "start logging"
/system/bin/timeout 5 /system/bin/logcat -b kernel | grep "Amp short error" > sdcard/amp.log &

sleep 1
#echo "enabling spk"
#audio-factory-test -f enable_spk
#agmplay /vendor/etc/spk.wav -D 100 -d 100 -i TDM-LPAIF-RX-TERTIARY-VIRT-0
#sleep 1
#echo "disabling spk"
#audio-factory-test -f disable_spk
playback.sh spk

line=`wc sdcard/amp.log |awk '{print $1}'`
echo "$line"

if [ $line -gt 0 ]; then
    echo "amp short detect: fail"
else
    echo "amp short detect: pass"
fi
exit 0
