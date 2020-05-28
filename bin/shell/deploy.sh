#!/bin/sh
DRY_OPTION=""
ARG=$1
# 引数が存在するかチェックし、なかったら終了
if [ $# -ne 1 ]; then
  echo "deploy.sh takes no arguments (1 given)"
  exit 1
fi
# 引数がdeployでなければファイルのリストアップのみ行う
if [ "$ARG" != "deploy" ]; then
    DRY_OPTION="--dry-run"
    echo "setting dry-run"
fi
if [ "$USER" != "appuser" ]; then
  echo "$USER Permission denied"
  exit 0
fi

GITROOT=/srv/news-app
WEBROOT=/home/sumi/news-app
# sorceコード
SRC_CORE=$GITROOT/
# destination コードのデプロイ先
DST_CORE=$WEBROOT/
# rsyncコマンド
RSYNC_COMMAND="rsync -av ${DRY_OPTION} --delete --exclude-from $GITROOT/bin/shell/exclude.lst"
LOCK_DIR="${GITROOT}/.update_lock"
echo "lockfile put"
# --------------------------------- lock and sync process start
echo "=== start ==="
# .update_lockが存在していなければif文内実行
if [ ! -e "$LOCK_DIR" ]; then
  mkdir $LOCK_DIR
  # --------------------------------- git pull
  cd ${GITROOT}
  echo "CMD> git pull"
  git pull
  # --------------------------------- rsync SRC2DST
  #cd ${WEBROOT}
  # rsyncコマンドで/srv/news-appから/home/sumi/news-app
  echo "CMD> $RSYNC_COMMAND $SRC_CORE $DST_CORE"
  $RSYNC_COMMAND $SRC_CORE $DST_CORE
  # --------------------------------- remove lockfile
  rmdir $LOCK_DIR
  cd ${WEBROOT}
  # インストールしていないgemがあるか確認
  bundle check >/dev/null
  if [ "$?" != "0" ]; then
    bundle install --path vendor/bundle
  fi
  # インストールしていないmoduleがあるか確認
  yarn check >/dev/null
  if [ "$?" != "0" ]; then
    yarn install
  fi
else
  echo "Can't update. The lock file exists."
fi
exit 0