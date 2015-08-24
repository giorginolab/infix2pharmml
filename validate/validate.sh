#!/bin/bash

# Needs the following:
#  git clone git@github.com:pharmml/pharmml-examples.git
#  git clone git@github.com:pharmml/pharmml-probonto.git
#  git clone git@github.com:pharmml/pharmml-spec.git

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export XML_CATALOG_FILES=$DIR/pharmml-spec/definitions/xmlCatalog.xml 

xmllint --nowarning --noout --schema $DIR/pharmml-spec/definitions/pharmml.xsd $1


