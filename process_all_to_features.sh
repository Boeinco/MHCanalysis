mkdir $1
cd $1

cp ../$2 ./
cp ../separate_peps_into_files.py ./
cp ../initial_umap.py ./

python3 separate_peps_into_files.py $2
mkdir features

for i in *scores/;
do
	echo $i
	cd $i
	find . -type f -empty -delete
	for d in *;
	do
		#echo $d
		python3 ../initial_umap.py $d ../features/$d.features
	done
	cd ../
done
