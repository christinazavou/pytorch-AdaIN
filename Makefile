
train-default:
	export SAVE_DIR=/mnt/nfs/work1/kalo/maverkiou/zavou/data/adain_default/checkpoints \
		&& export LOG_DIR=/mnt/nfs/work1/kalo/maverkiou/zavou/data/adain_default/checkpoints/logs \
		&& export CONTENT_DIR=/mnt/nfs/work1/kalo/maverkiou/zavou/data/coco2017/train2017 \
		&& export STYLE_DIR=/mnt/nfs/work1/kalo/maverkiou/zavou/data/wikiart/train \
		&& export VGG_PATH=/mnt/nfs/work1/kalo/maverkiou/zavou/data/vgg_normalised.pth \
		&& export MAIN_FILE=train.py \
		&& sbatch --job-name=adain --partition=titanx-long train.sh
