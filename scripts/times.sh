#! /bin/bash

I=0
for STAT_VAR in `eval cat /proc/$PPID/stat` ; do
    if [ $I -lt 10 ] ; then
	echo -n " "
    fi
    echo -n "$I: "
    let I=I+1
    case "$I" in
	1)
	    echo -n "pid:     "
	    ;;
	2)
	    echo -n "comm:    "
	    ;;
	3)
	    echo -n "state:   "
	    ;;
	4)
	    echo -n "ppid:    "
	    ;;
	5)
	    echo -n "pgrp:    "
	    ;;
	6)
	    echo -n "session: "
	    ;;
	7)
	    echo -n "tty_nr:  "
	    ;;
	8)
	    echo -n "tpgid:   "
	    ;;
	9)
	    echo -n "flags:   "
	    ;;
	10)
	    echo -n "minflt:  "
	    ;;
	11)
	    echo -n "cminflt: "
	    ;;
	12)
	    echo -n "majflt:  "
	    ;;
	13)
	    echo -n "cmajflt: "
	    ;;
	14)
	    echo -n "utime:   "
	    ;;
	15)
	    echo -n "stime:   "
	    ;;
	16)
	    echo -n "cutime:  "
	    ;;
	17)
	    echo -n "cstime:  "
	    ;;
	18)
	    echo -n "prio:    "
	    ;;
	19)
	    echo -n "nice:    "
	    ;;
	20)
	    echo -n "num_thr: "
	    ;;
	21)
	    echo -n "itreal:  "
	    ;;
	22)
	    echo -n "startt:  "
	    ;;
	23)
	    echo -n "vsize:   "
	    ;;
	24)
	    echo -n "rss:     "
	    ;;
	25)
	    echo -n "rsslim:  "
	    ;;
	26)
	    echo -n "startc:  "
	    ;;
	27)
	    echo -n "endcode: "
	    ;;
	28)
	    echo -n "startst: "
	    ;;
	29)
	    echo -n "kstkesp: "
	    ;;
	30)
	    echo -n "kstkeip: "
	    ;;
	31)
	    echo -n "signal:  "
	    ;;
	32)
	    echo -n "blocked: "
	    ;;
	33)
	    echo -n "sigign:  "
	    ;;
	34)
	    echo -n "sigctch: "
	    ;;
	35)
	    echo -n "wchan:   "
	    ;;
	36)
	    echo -n "nswap:   "
	    ;;
	37)
	    echo -n "cnswap:  "
	    ;;
	38)
	    echo -n "exitsig: "
	    ;;
	39)
	    echo -n "prcssr:  "
	    ;;
	40)
	    echo -n "rt_prio: "
	    ;;
	41)
	    echo -n "policy:  "
	    ;;
	42)
	    echo -n "d_b_t:   "
	    ;;
	43)
	    echo -n "gst_t:   "
	    ;;
	44)
	    echo -n "cgst_t:  "
	    ;;
	*)
	    echo -n "unknown option: "
	    ;;
    esac
    echo $STAT_VAR

done
