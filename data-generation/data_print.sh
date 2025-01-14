#!/bin/bash  
  
category=""
data=""
exp_name="" 
version_name=""
iter=""

usage() { echo "Usage: $0 --category <algebra/...> --data <train/test> --exp_name <EXP_NAME> --version_name <e0> --iter <1/2/...>" 1>&2; exit 1; }

# Check that we have at least one argument:
if [ $# -eq 0 ]; then
    usage
fi

# Parse the command line arguments:
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        --category)
        category="$2"
        shift 
        shift 
        ;;
        --data)
        data="$2"
        shift 
        shift
        ;;
        --exp_name)
        exp_name="$2"
        shift 
        shift
        ;;
        --version_name)
        version_name="$2"
        shift 
        shift
        ;;
        --iter)
        iter="$2"
        shift 
        shift
        ;;
        *)    # unknown option
        usage
        ;;
    esac
done

if [ -z "${category}" ] || [ -z "${data}" ] || [ -z "${exp_name}" ] || [ -z "${version_name}" ]; then
    usage
fi

if [ "$category" == "all" ]; then  
    category="algebra,counting_and_probability,geometry,intermediate_algebra,number_theory,prealgebra,precalculus"  
fi

ARGS="--category ${category} --data ${data} --exp_name ${exp_name} --version_name ${version_name} --iter ${iter} --ub 1.0 --lb 0.9"
python data_print.py ${ARGS}

ARGS="--category ${category} --data ${data} --exp_name ${exp_name} --version_name ${version_name} --iter ${iter} --ub 1.0 --lb 0.99"
python data_print.py ${ARGS}

ARGS="--category ${category} --data ${data} --exp_name ${exp_name} --version_name ${version_name} --iter ${iter} --ub 0.5 --lb -1.0"
python data_print.py ${ARGS}

ARGS="--category ${category} --data ${data} --exp_name ${exp_name} --version_name ${version_name} --iter ${iter} --ub 1.0 --lb -1.0"
python data_print.py ${ARGS}