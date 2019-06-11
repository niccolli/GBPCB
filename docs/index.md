# GBCartridge

![本体画像](https://github.com/niccolli/cartridge/blob/master/docs/images/cartridge.jpg?raw=true)

自作のゲームボーイ用カートリッジです。自分で作ったゲームやMBC内機能を、実機で動作させることができます。

## 機能

MBC5相当のカートリッジとして動作します。

### バッテリーバックアップをサポート

本体の電源OFF時にカートリッジ側RAMの内容を保持するバッテリーバックアップを実装しています。別売りのCR2032をセットすると、電源OFF時にRAMデータをすべてマイコン内のROMに書き込みます。次回本体起動時に保存されたデータをRAMに展開しますので、電源OFFの間は本体の電池を取り外してもRAMの内容は保持されます。

### USB経由のデータ読み書き

カートリッジROM/RAM、およびMBCの機能はすべてUSB経由で書き込めます。バッテリーバックアップにて保存されたRAMのデータも、USB経由で読み出すことが可能です。

## 使い方

### 購入後

- アクリルカバーは両面の保護シートをはがしてください。
- 本体四隅のネジを外し、アクリルカバーを載せてから再度ネジ止めしてください。
- 購入後は正常動作を確認できるように、カラーバーが表示されるソフトウェア([GBDKのサンプルコード](http://gbdk.sourceforge.net/examples.html)です)が書き込まれています。

### 書き換え

インタフェースとして[dfu-util](http://dfu-util.sourceforge.net)を使用しています。macOS / Windows / Linuxのそれぞれで動作します。

書き換えの際はボタン電池を抜いてください。コイン電池が入ったままUSBで接続した場合は、USBケーブルを抜いたあとに電池を一度取り外してください。

#### macOS / Linuxの場合

1. dfu-utilを、PATHが通っている箇所にインストールしてください。各種パッケージマネージャーを使用していれば、そちらからインストールすると便利です。
2. カートリッジの[リポジトリ](https://github.com/niccolli/cartridge)をクローン、またはダウンロードしてください。
3. ターミナルから、toolsフォルダ内のpcbif.shを実行してください。

- ./pcbif.sh --write-rom ファイル名
    - 指定したファイルの内容を、マイコンのカートリッジROM領域に展開します。
- ./pcbif.sh --write-ram ファイル名
    - 指定したファイルの内容を、マイコンのカートリッジRAM領域に展開します。
- ./pcbif.sh --write-mbc ファイル名
    - 指定したファイルの内容を、マイコンの先頭(MBC領域)に展開します。
- ./pcbif.sh --read-ram ファイル名
    - 指定したファイルに、カートリッジRAMの内容を保存します。

#### Windowsの場合

USBで本体とPCを接続し、dfu-utilで書き換えを行おうとしても「Cannot open DFU device 0483:df11 No DFU capable USB device available」と表示される場合は、ドライバの入れ替えが必要です。[こちら](https://seeedjp.github.io/Wiki/Wio_LTE_for_Arduino/ReplaceDriver-ja.html)の記載に従ってドライバを入れ替えたあとに、再度試してください。バージョンは2.4でも動作します。

1. [SourceForge](https://sourceforge.net/projects/dfu-util/files/)からWindows用のdfu-util (dfu-util-0.9-win64.zip) をダウンロードします。
2. カートリッジの[リポジトリ](https://github.com/niccolli/cartridge)をクローン、またはダウンロードしてください。
3. cartridgeフォルダ内のtoolsフォルダに、1でダウンロードした dfu-util.exe をコピーします。
4. PowerShellから、toolsフォルダ内の.\pcbif.ps1を実行してください。

- .\pcbif.ps1 -WriteROM ファイル名
    - 指定したファイルの内容を、マイコンのカートリッジROM領域に展開します。
- .\pcbif.ps1 -WriteRAM ファイル名
    - 指定したファイルの内容を、マイコンのカートリッジRAM領域に展開します。
- .\pcbif.ps1 -WriteMBC ファイル名
    - 指定したファイルの内容を、マイコンの先頭(MBC領域)に展開します。
- .\pcbif.ps1 -ReadRAM ファイル名
    - 指定したファイルに、カートリッジRAMの内容を保存します。

PowerShellから「このシステムではスクリプトの実行が無効になっているため……」というエラーが表示される場合、シェル上で "powershell -ExecutionPolicy RemoteSigned .\pcbif.ps1 オプション" として実行してください。

複数のオプションを指定した場合、上のものを優先します。

## 制限

- MBC5相当の機能を持っていますが、カートリッジROMの容量は基本的に1MBまでです。
- ゲームボーイカラーで使用される倍速モードには非対応です。
    - 白黒ゲームボーイでは動作します。
    - ゲームボーイカラーでは[倍速モード](http://gbdev.gg8.se/wiki/articles/CGB_Registers#FF4D_-_KEY1_-_CGB_Mode_Only_-_Prepare_Speed_Switch)を使用しない限りは動作します。
- CPUが4MHzの環境でのみ動作を確認しています。それ以降の機種では動作を確認していません。ご理解ください。

## 注意

- MicroUSBコネクタは外れやすいので、抜き差しの際にはまっすぐに、不用意な力がかからないように気をつけてください。
- コイン電池が挿入されている状態で、電池横のカバー支柱に針金等導電性の物を触れさせないでください。ショートして電池が破裂します。テープでふさぐなどして対応ください。

## 謝辞

このカートリッジの仕組みは、Dholeさんが公開していたものを利用しています。

- [Emulating a GameBoy Cartridge with an STM32F4. Part 1](https://dhole.github.io/post/gameboy_cartridge_emu_1/)
- [Emulating a GameBoy Cartridge with an STM32F4. Part 2](https://dhole.github.io/post/gameboy_cartridge_emu_2/)
- [Booting the GameBoy with a custom logo](https://dhole.github.io/post/gameboy_custom_logo/)
