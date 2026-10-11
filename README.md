# 菌岩 · 设计与记录

基于 [Hux Blog](https://github.com/Huxpro/huxpro.github.io) 改造的 Jekyll 个人博客与三维设计作品集。网站名称为「菌岩」，使用 Liquid 模板和 Markdown 内容，通过 GitHub Pages 发布。

- 正式网站：[junyan3d.github.io](https://junyan3d.github.io/)
- 源码仓库：[junyan3d/junyan3d.github.io](https://github.com/junyan3d/junyan3d.github.io)

已发布版本为 **v0.1.0**。本地管理器的分类、个人资料数据结构调整尚未同步线上，首次使用发布按钮时会一并列出待确认改动。

## 1. 项目解决什么问题

将设计记录、不同学习与工作阶段的作品、个人介绍集中在一个可维护的网站中。维护者通过编辑文件更新内容，访客通过浏览器阅读文章、按分类浏览作品、查看图片和主动播放项目视频。

公开网站是静态网站，没有在线后台或访客账号。本机提供独立的图形化内容管理器，可通过表单维护内容与选择素材。原始简历、作品集 PDF 和演示文稿不随网站公开；网站展示的是整理后的文字与素材副本。

## 2. 主要功能

- **首页**：文章摘要、日期、标签及分页；每页最多 6 篇文章，侧栏提供个人介绍、精选作品和邮箱入口。当前保留一篇明确标注的示例文章。
- **作品**：按「工作、硕士、本科」分组，以侧边悬浮按钮跳转；项目卡片进入详情页。
- **项目详情**：图片、图片说明、带封面的原生视频播放器和返回作品集链接。视频由访客主动播放，加载失败时提供提示及单独打开链接。
- **归档**：按年份排列文章，可通过标签链接筛选。
- **关于**：个人介绍、工作与教育经历、研究与技能、兴趣、邮箱。
- **视觉与导航**：四个主页面使用不同封面，首页采用低饱和三维景观风格；关于页通过分区下划线强化阅读层次。支持桌面与手机布局、手机菜单及自定义 404 页面。
- **社交链接**：页脚提供 B站、抖音、小红书、GitHub 跳转按钮；首页侧栏和关于页正文不显示这组按钮。
- **发布**：推送到 `main` 分支后，由 GitHub Actions 构建并部署到 GitHub Pages。

评论、访问统计、广告和离线缓存默认关闭。素材转换与封面生成是制作过程中完成的处理，网站本身不提供自动提取 PPTX、图片生成或视频转码功能。

## 3. 安装方法

### 获取源码

已有本地项目时，直接进入 `website/` 目录。新电脑可运行：

```sh
git clone https://github.com/junyan3d/junyan3d.github.io.git
cd junyan3d.github.io
```

以下命令均在项目根目录（包含 `Gemfile` 的目录）执行。

### 安装依赖

需要 Git、Ruby 和 RubyGems。当前电脑使用 Ruby 2.6 兼容本地预览，已安装的依赖位于 `vendor/bundle`；线上构建使用 Ruby 3.3。新环境建议安装 Ruby 3.3，与线上保持一致。

```sh
ruby --version
gem install bundler -v 2.4.22 --install-dir vendor/bundle --no-document
export GEM_HOME="$PWD/vendor/bundle"
export GEM_PATH="$PWD/vendor/bundle"
ruby vendor/bundle/gems/bundler-2.4.22/exe/bundle config set --local path vendor/bundle
ruby vendor/bundle/gems/bundler-2.4.22/exe/bundle install
```

首次安装需要联网。部分依赖需要编译：macOS 需具备 Xcode Command Line Tools，Linux 需安装编译工具及 Ruby 开发头文件。依赖版本由 `Gemfile` 和 `Gemfile.lock` 管理；不要将 `vendor/` 上传到仓库。

## 4. 使用方法

### 本地预览与构建

```sh
./scripts/serve.sh
```

打开 [http://127.0.0.1:4000/](http://127.0.0.1:4000/)，按 `Ctrl+C` 停止。脚本使用项目内依赖及轮询监听，内容修改后自动构建；修改 `_config.yml` 后需重启。端口占用时先关闭已有服务，或使用 `./scripts/serve.sh --port 4001` 并访问对应端口。

仅生成静态文件：

```sh
export GEM_HOME="$PWD/vendor/bundle"
export GEM_PATH="$PWD/vendor/bundle"
ruby vendor/bundle/gems/bundler-2.4.22/exe/bundle exec jekyll build
```

输出位于 `_site/`。该目录由构建生成，不应直接编辑；浏览网站应使用预览网址，直接打开 `_layouts/project.html` 等模板文件会显示模板代码。

### 修改资料与封面

| 文件或目录 | 用途 |
| --- | --- |
| `_config.yml` | 网站名称、简介、邮箱、正式网址、分页数量、社交链接及集合配置 |
| `_data/profile.yml` | 个人介绍与经历；about.md 为展示模板 |
| `_data/categories.yml` | 作品分类及顺序 |
| `_posts/` | Markdown 博客文章 |
| `_projects/` | 项目资料及详情正文 |
| `assets/images/` | 作品图片与视频预览图 |
| `assets/videos/` | 网页展示视频 |
| `assets/covers/` | 当前页面使用的 WebP 封面 |
| `_layouts/`、`_includes/` | 页面模板与公共组件 |
| `css/personal.css`、`js/personal.js` | 自定义样式与交互 |
| `.github/workflows/pages.yml` | 自动构建与发布流程 |

`social_links` 每项包含 `title`、`icon`、`url`，可选 `hint`；当前图标支持 `bilibili`、`douyin`、`xiaohongshu`、`github`。关于页经历由 `_data/profile.yml` 管理，分类由 `_data/categories.yml` 管理。主页面的 `header-img` 在页面头部配置，首页默认封面由 `_config.yml` 设置。封面生成提示词保存在 `scripts/cover-prompts.md`。

### 图形化管理（推荐）

双击外层的 `管理网站.app`（备用入口 `管理网站.command`） 即可打开本机管理器。文章、作品、分类、个人资料、封面和社交链接都可在界面中维护；保存只修改本地，发布需单独确认。使用说明见外层 `manager/README.md`。管理器、原件、备份和回收区位于网站目录之外，不参与公开发布。

### 写文章

在 `_posts/` 新建 `YYYY-MM-DD-slug.md`，设置 `layout: post`、标题、可选副标题及标签，再编写 Markdown 正文。超过 6 篇文章时自动分页。没有文章时首页显示空状态；未来日期文章默认不会被 Jekyll 发布。

### 添加作品

在 `_projects/` 新建 `slug.md`，使用 YAML 或现有项目的 JSON 头部，正文使用 Markdown：

- `category` 必须与 `_data/categories.yml` 中的分类名称一致，才能出现在对应分组。现有分类为「工作」「硕士」「本科」，可在管理器中新增或调整。
- `order` 为排序数值；`cover` 为项目卡片封面。
- `images` 每项包含 `src`、`alt`、`caption`。
- `videos` 每项包含 `src`、`poster`、`title`；没有视频时使用 `videos: []`。

将素材副本放入 `assets/`，引用路径以 `/assets/` 开头。推荐使用英文文件名，避免手动拼写或编码错误。视频建议使用 H.264、yuv420p 的 MP4，并设置 faststart；有音频时使用 AAC。视频封面应来自对应视频。当前 AI 视角旋转视频采用 H.264 Baseline，其余展示视频主要采用 High 配置。

### 发布更新

本地检查完成后，提交并推送到 `main` 才会触发线上更新：

```sh
git add <本次修改的文件>
git commit -m "Update website content"
git push origin main
```

在仓库 **Actions → Publish website** 查看构建与部署结果。只修改本地文件、不推送时，线上网站保持原样。`README.md` 被排除在 Jekyll 页面输出之外。

## 5. 输入输出示例

### 示例一：新增文章

**输入**：新建 `_posts/2026-10-10-light-study.md`：

```markdown
---
layout: post
title: "光影练习"
subtitle: "一组材质与照明观察"
tags: [Blender, 设计记录]
---
本次记录同一模型在不同照明下的视觉变化。

## 观察
柔和侧光能够更清楚地呈现表面起伏。
```

**输出**：构建后生成 `_site/blog/2026/10/10/light-study/index.html`，本地访问 `/blog/2026/10/10/light-study/`。首页出现文章摘要，归档出现日期与标题，标签链接可筛选对应文章。此示例仅为说明，未作为实际文章添加。

### 示例二：已有 AI 项目的资料与页面

**输入**：`_projects/ai-workflow.md` 的资料包含：

```yaml
title: AI 辅助车型设计
description: "ComfyUI、DeepSeek 与可灵AI的联合探索：车型图像生成、摩托车视角旋转与本地 ComfyUI 工作流。"
category: 工作
order: 4.5
cover: /assets/images/ai-workflow-2.jpg
images:
  - src: /assets/images/ai-workflow-2.jpg
    alt: ComfyUI 车型生成结果
    caption: ComfyUI 车型生成结果
videos:
  - src: /assets/videos/ai-workflow-rotation-v2.mp4
    poster: /assets/images/ai-workflow-1-poster.jpg
    title: 摩托车视角旋转
```

以上是现有资料的部分字段，实际文件使用 JSON 头部并包含 3 张图片。JSON 同样可用于 Jekyll 头部。

**输出**：作品页的「工作」分组显示项目卡片；`/works/ai-workflow/` 展示项目介绍、3 张图片和 1 段带封面的视频。生成文件位于 `_site/works/ai-workflow/index.html`。

### 示例三：标签筛选

**输入**：访问 `/archive/?tag=设计记录`。

**输出**：归档只显示带有「设计记录」标签的文章，并显示筛选结果数量。浏览器可能将中文参数显示为百分号编码，两者含义相同。

## 主题来源与许可证

主题改造自 [Hux Blog](https://github.com/Huxpro/huxpro.github.io)，保留项目 `LICENSE`（Apache-2.0）及页脚主题署名。个人介绍与作品资料来源说明见 `SOURCE.md`；原始素材保留在本地项目外层目录中，仓库仅包含网站所用副本。


## 本地素材留档与公开范围

已撤下的展示素材、旧首页封面和生成 PNG 原图移至网站目录外的 `../output/local-archive/`，不参与网站构建。原始简历和作品集仍保留在外层目录。请仅发布网站项目目录，勿将外层原始资料或本地留档一起上传。

当前网页素材目录只保留展示所需文件。移除项目里的图片或视频条目时，也应将对应素材移出 `assets/`；仅删除页面引用，文件仍可能通过网址直接访问。

`.gitignore` 已忽略本地依赖、构建输出、系统文件、常见凭据文件、原始 PDF/PPTX 及临时文件。这些规则只影响尚未被 Git 跟踪的文件，不能清除已提交的文件或历史记录。v0.1.0 已将撤下素材与绝对路径移出当前发布版本；未改写公开 Git 历史，旧素材与路径仍可能存在于历史提交或缓存中。

封面提示词中的素材位置已改为相对路径。检查报告位于外层 `../output/privacy-audit.md`，不参与网站发布。工作作品的公开范围仍应依据实际授权确认。
