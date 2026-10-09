# 菌岩 · 设计与记录

基于 Hux Blog 的本地 Jekyll 博客与作品集，未发布到线上。

## 本地预览

在 website 目录运行 `./scripts/serve.sh`，访问 http://127.0.0.1:4000 。按 Ctrl+C 关闭。修改页面会自动构建，修改 `_config.yml` 后需重启。

当前使用系统 Ruby 2.6 与 Jekyll 3.9，依赖安装在 `vendor/bundle`。这是为现有电脑提供的兼容预览环境；正式上线前建议升级至受支持的 Ruby/Jekyll 版本并复验。

重新安装依赖：`gem install bundler -v 2.4.22 --install-dir vendor/bundle --no-document`，然后设置 `GEM_HOME="$PWD/vendor/bundle" GEM_PATH="$PWD/vendor/bundle"`，运行 `ruby vendor/bundle/gems/bundler-2.4.22/exe/bundle install`。

## 网站资料

`_config.yml` 集中设置网站标题、简介、邮箱和网址。可在 `social_links` 中添加 `title` / `url`，首页侧栏会显示。当前网址是本地地址，未来部署需替换。`about.md` 维护个人经历。

## 写文章

在 `_posts` 新建 `YYYY-MM-DD-slug.md`。复制现有示例的头部，设置 `layout: post`、`title`、`subtitle`、`tags`，然后撰写 Markdown。示例文章已明确标记，正式发布前请替换或删除。每页显示 6 篇文章，超出后自动分页。归档支持标签筛选。

## 添加作品

在 `_projects` 新建 `slug.md`，复制一个现有项目的 JSON 头部（JSON 是合法 YAML）。填写 `title`、`category`（工作/硕士/本科）、`description`、`order`、`cover`、`images`、`videos`。`images` 每项包含 `src`、`alt`、`caption`；`videos` 每项包含 `src`、`poster`、`title`。路径以 `/assets/` 开头。图片放在 `assets/images`，视频放在 `assets/videos`，推荐使用英文文件名。所有原始素材均保持不变，网站使用副本。

无确切项目归属的未命名素材未纳入展示，避免错误归因。没有评论、广告、访问统计或离线缓存。视频不会自动播放。原始简历与作品集文件不在网站内。

## 构建与检查

设置上述 GEM_HOME/GEM_PATH 后运行 `ruby vendor/bundle/gems/bundler-2.4.22/exe/bundle exec jekyll build`。生成目录为 `_site`，不应直接编辑。本地地址的不存在页面返回 404 提示。

主题来自 [Hux Blog](https://github.com/Huxpro/huxpro.github.io)，保留 Apache-2.0 许可证及页面署名。

## 本次更新

网站对外显示名为菌岩，邮箱为 junyan3d@gmail.com。社交按钮位于关于页和页脚。`social_links` 集中配置四个平台链接；B站、小红书、GitHub 已配置个人主页，抖音使用提供的公开分享链接。

四个主页面封面在 `assets/covers/`，保留生成 PNG 与网页 WebP 副本。视频为 H.264 High Level 4.1、30fps、yuv420p、AAC（有音频时），MP4 使用 faststart；每段视频配有从本视频提取的预览图，原始素材未修改。被移除的视频仅移出网站展示，原始文件仍保留。

新增工作项目「AI 辅助车型设计」，依据 250520AI整理.pptx 提取车型图像、视角旋转视频和工作流截图，原始演示文稿未改动。

预览服务使用轮询检测文件变化，适用于本机文件监听受限的情况。修改 `_config.yml` 后仍需重新启动。


## 在线发布
正式网站：https://junyan3d.github.io/
源码仓库：https://github.com/junyan3d/junyan3d.github.io

网站通过 GitHub Actions 构建并发布到 GitHub Pages。更新文章、项目或素材后，提交并推送到 main 分支，等待仓库 Actions 中的 Publish website 成功即可上线。构建依赖由 Gemfile.lock 固定，云端使用 Ruby 3.3。

本地仍通过 scripts/serve.sh 预览。不要直接打开 _layouts 中的模板文件。
