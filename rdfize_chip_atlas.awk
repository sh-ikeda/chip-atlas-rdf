### 

BEGIN {
    OFS = "\t"
    FS = "\t"

    print "@prefix ro:   <http://purl.obolibrary.org/obo/> ."
    print "@prefix ensg: <http://identifiers.org/ensembl/> ."
    print ""
}

FNR==1 {
    fc++
}

# idmap.tsv
fc==1 {
    if($3)
        sym2id[$1] = gensub(/\.[0-9]+$/, "", "g", $3)
}

### <TF>.10.tsv
fc>=2 && FNR==1 {
    tf_sym = gensub(/(^.*\/)|(\.[0-9]+\.tsv)/, "", "g", FILENAME)
    if(sym2id[tf_sym]) {
        tf_id = sym2id[tf_sym]
    }
    else {
        print "ERROR: " FILENAME " exists but " tf_sym " is not defined as a unique and valid symbol." > "/dev/stderr"
        nextfile
    }
}

fc>=2 && FNR>=2 {
    if(sym2id[$1]) {
        print "ensg:" tf_id " ro:RO_0002428 ensg:" sym2id[$1] " ."
    }
    else {
        # print FILENAME ":" FNR ": " $1 " is not a unique and valid symbol." > "/dev/stderr"
        # exit 1
        # print $1
    }
}

END {
    
}
