#!/bin/bash 

# Move the generated rj-flat or rj-nested file to corresponding measure folder

# get user input, either flat or nested
FILENAME=$1
FLATDIR="flat-measure"
NESTDIR="nested-measure"

if [ "$#" -ne 1 ]; then
	echo "Enter the FULL NAME of the file to be moved"
	echo "Valid: rj-flat, rj-flat-r, rj-nested, rj-nested-r"
	exit
fi

isFlat=false

if [ "$FILENAME" == "rj-flat" ] || [ "$FILENAME" == "rj-flat-r" ]; then
	TOTAL=`ls $FLATDIR | grep -Eo '[0-9]{1,3}' | sort -nr | head -1`
	isFlat=true 
elif [ "$FILENAME" == "rj-nested" ] || [ "$FILENAME" == "rj-nested-r" ]; then
	TOTAL=`ls $NESTDIR | grep -Eo '[0-9]{1,3}' | sort -nr | head -1`
else 
	echo "Unknown parameter"
	exit
fi

echo $TOTAL "existing measures are found"

NEW=$(expr $TOTAL + 1)
DIRNAME="measure"$NEW

echo "Directory" $DIRNAME "will be created"

echo "Please enter the README file content"
read READMECONTENT

if [ "$isFlat" = "true" ]; then 
	mkdir $FLATDIR/$DIRNAME &&
	mv $FILENAME $FLATDIR/$DIRNAME/ &&
	echo $READMECONTENT > $FLATDIR/$DIRNAME/README	
else 
	mkdir $NESTDIR/$DIRNAME && 
	mv $FILENAME $NESTDIR/$DIRNAME/ && 
	echo $READMECONTENT > $NESTDIR/$DIRNAME/README
fi
