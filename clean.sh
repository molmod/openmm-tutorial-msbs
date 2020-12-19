#!/usr/bin/env bash

# Strip withspace form markdown files
for file in $(find . | grep 'md$'); do
  echo Cleaning ${file}
  sed -i -e $'s/\t/    /g' ${file}
  sed -i -e $'s/[ \t]\+$//' ${file}
  sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' ${file}
done

# Remove nbconvert outputs
rm */*.nbconvert.ipynb

# Strip output cells from notebooks
for file in $(git ls-files | grep 'ipynb$'); do
  echo Cleaning ${file}
  jupyter nbconvert ${file} --to notebook  --inplace --nbformat 4 --ClearOutputPreprocessor.enabled=True
done

