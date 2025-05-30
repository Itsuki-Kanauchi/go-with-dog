class AvatarUploader < CarrierWave::Uploader::Base
  # アップロードされたファイルの保存ディレクトリ
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # ファイルがアップロードされていないときのデフォルト画像
  def default_url
    'sample.jpg' # publicディレクトリ配下のパスが対象（例: public/sample.jpg）
  end

  # 許可する拡張子のホワイトリスト
  def extension_allowlist
    %w(jpg jpeg gif png)
  end
end
