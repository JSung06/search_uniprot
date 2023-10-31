# Search Uniprot IDs

### USAGE:
```bash
$ bash search_uniprot.sh <tsv_file> <text_file_containing_uniprot_ids_to_search>
```

### OUTPUT:
- The results of each ID will be stored in `./results/[Uniprot ID].txt`
- Non matching IDs will be listed in `./results/non_matching.txt`

### N.B.:
- During the first run, `./results` directory will be automatically created
- Uniprot IDs in the text file should be line separated i.e., one ID per line (c.f. `uniprot_id_example.txt`)
- All output files overwrite by default
