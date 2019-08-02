#!/bin/bash
#
HOST="hsc-ctschf.health.unm.edu"
DATADIR="/home/jjyang/src/cerner-tools/data"
#
ftypes="diagnosis lab medication"
#
n_sk=$(ssh $HOST cat $DATADIR/hf_neph_cohort.sk |wc -l)
#
for ftype in $ftypes ; do
	n=$(ssh $HOST cat $DATADIR/hf_neph_cohort_f_${ftype}.tsv |sed -e 's/,.*$//' |sort -u |wc -l)
	printf "Nephrology patient PKs done (facttype: $ftype): %d / %d (%d%%)\n" \
		"$n" \
		"$n_sk" \
		"$((100 * $n / $n_sk))"
done
#