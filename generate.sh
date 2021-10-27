#pandoc ../../documents/fluroescence.md -o fluorescence.html
pandoc --filter pandoc-citeproc --bibliography=../../documents/references.bib -s ../../documents/fluorescence.tex -o README.md
pandoc --filter pandoc-citeproc --bibliography=../../documents/references.bib -s ../../documents/fluorescence.tex -o paper.pdf