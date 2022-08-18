# FFIs
さまざま言語でFFI(Foreign function interface)したいね、というレポジトリ

## 今の工程
```
python -> asm -> fortran -> asm -> python -> asm 
```

## 実行方法
```
make run
```

## 必要なツールチェイン
```
python3 gcc gfortran
```
apt を用いたインストール
```
sudo apt install python3 gcc gfortran
```