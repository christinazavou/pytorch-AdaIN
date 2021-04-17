#!/bin/bash
#SBATCH -o %j.out
#SBATCH -e %j.err
#SBATCH --partition=titanx-long    # Partition to submit to
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
#SBATCH --time=7-00:00         # Maximum runtime in D-HH:MM


SAVE_DIR=${SAVE_DIR:-coco_wikiart_ckpts}
LOG_DIR=${LOG_DIR:-coco_wikiart_logs}
CONTENT_DIR=${CONTENT_DIR:-coco2017}
STYLE_DIR=${STYLE_DIR:-wikiart}
VGG_PATH=${VGG_PATH:-vgg_normalised.pth}
MAIN_FILE=${MAIN_FILE:-train.py}
echo "SAVE_DIR ${SAVE_DIR}"
echo "LOG_DIR ${LOG_DIR}"
echo "CONTENT_DIR ${CONTENT_DIR}"
echo "STYLE_DIR ${STYLE_DIR}"
echo "MAIN_FILE ${MAIN_FILE}"

args="--content_dir ${CONTENT_DIR}"
args="${args} --style_dir ${STYLE_DIR}"
args="${args} --vgg ${VGG_PATH}"
args="${args} --save_dir ${SAVE_DIR}"
args="${args} --log_dir ${LOG_DIR}"

export PYTHONUNBUFFERED="True"

PY_EXE=/home/maverkiou/miniconda2/envs/adain/bin/python
SOURCE_DIR=/home/maverkiou/zavou/pytorch-AdaIN

VERSION=$(git rev-parse HEAD)

TIME=$(date +"%Y-%m-%d_%H-%M-%S")
LOG="$LOG_DIR/$TIME.txt"

mkdir -p $LOG_DIR
mkdir -p $SAVE_DIR

echo Logging output to "$LOG"
echo "Version: ${VERSION}" > "$LOG"
echo -e "GPU(s): $CUDA_VISIBLE_DEVICES" >> $LOG
echo "cd ${SOURCE_DIR} && ${PY_EXE} ${MAIN_FILE} $args" >> "$LOG"
cd ${SOURCE_DIR} && ${PY_EXE} ${MAIN_FILE} $args 2>&1 | tee -a "$LOG"
