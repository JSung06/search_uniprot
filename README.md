# Search Uniprot IDs

### USAGE:
`$ bash search_uniprot.sh <tsv_file> <text_file_containing_uniprot_ids_to_search>`


### OUTPUT:
- The results of each ID will be stored in `./results/[Uniprot ID].txt`
- Non matching IDs will be listed in `./results/non_matching.txt`

### N.B.:
- Uniprot IDs in the text file should be line separated i.e., one ID per line
- All output files overwrite by default
