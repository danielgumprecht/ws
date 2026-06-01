chkdsk /scan /perf
/sfc scannow
dism /online /cleanup-image /restorehealth
echo "System check complete. Please review the results above for any issues."