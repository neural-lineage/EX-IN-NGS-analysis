modifications were made to make it for zebrafish bulk CUT&Tag analysis. The main function of the modifications is to add zebrafish genome and neglect the blacklist calculation.

#when you need to analyze zebrafish cut&tag result, do as the following steps:
1, Install  CUT-RUNTools-2.0 firstly
2, construct zebrafish index (GRCz11) with bowtie2
3, add zebrafish genome sequence (danRer11) folder including into CUT-RUNTools-2.0/install/assemblies
4, add run_bulkModule_danRer11.sh to CUT-RUNTools-2.0/
5, replace CUT-RUNTools-2.0/src/bulk/bulk-pipeline.sh with bulk-pipeline
6, modify bulk-config_her15.1.json according to your need, copy the script into your work directly
example usage to analyze her15.1 CUT&Tag result: path/CUT-RUNTools-2.0/run_bulkModule_danRer11.sh path/bulk-config_her15.1.json her15.1

Note: back to the origin version of run_bulkModule.sh and  bulk-pipeline.sh otherwise

# run_bulkModule_danRer11.sh is modified from CUT-RUNTools-2.0/run_bulkModule.sh
## modification1: line24-25, neglect black list treatment
## modification2:line 38-62, fix genome size to zebrafish genome size, eGenomeSize=1373454788

#bulk-pipeline.sh is modified from CUT-RUNTools-2.0/src/bulk/bulk-pipeline.sh
## modification 1: line219-228, fix genome to zebrafish genome,  “-g $macs2_genome” to "-g 1.5e9"
## modification 2: line328-329, neglect blacklist treatment
## modification 3: line 386, neglect blacklist treatment