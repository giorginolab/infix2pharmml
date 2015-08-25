#!/bin/bash

# Needs the following:
#  git clone git@github.com:pharmml/pharmml-examples.git
#  git clone git@github.com:pharmml/pharmml-probonto.git
#  git clone git@github.com:pharmml/pharmml-spec.git

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


if [[ -z $2 ]]; then
	DEF=$DIR/pharmml-spec/definitions
else
	DEF=$DIR/$2/definitions
fi


export XML_CATALOG_FILES=$DEF/xmlCatalog.xml 

xmllint --nowarning --noout --schema $DEF/pharmml.xsd $1


