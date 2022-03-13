pandoc --toc --bibliography=../../documents/references.bib -t html -s ../../documents/fluorescence.tex -o README.html --citeproc --mathjax --metadata title="a" --metadata link-citations=true
pandoc --toc --bibliography=../../documents/references.bib -t markdown -s ../../documents/fluorescence.tex -o README.md --citeproc
