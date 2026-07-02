#import "@preview/touying:0.6.1": *
#import themes.simple: *
#import "@preview/cetz:0.3.2"
#import "@preview/fletcher:0.5.5" as fletcher: edge, node
#import "@preview/numbly:0.1.0": numbly
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

// cetz and fletcher bindings for touying
#let cetz-canvas = touying-reducer.with(reduce: cetz.canvas, cover: cetz.draw.hide.with(bounds: true))
#let fletcher-diagram = touying-reducer.with(reduce: fletcher.diagram, cover: fletcher.hide)

// Color shorthand functions
#let redt(content) = text(fill: red, content)
#let bluet(content) = text(fill: blue, content)
#let greent(content) = text(fill: green, content)
#let yellowt(content) = text(fill: yellow, content)
#let oranget(content) = text(fill: orange, content)
#let purplet(content) = text(fill: purple, content)
#let greyt(content) = text(fill: gray, content)
#let grayt(content) = text(fill: gray, content)

// Set Chinese fonts using Source Han VF fonts
#set text(
  font: (
    "Source Han Serif",
  ),
)

#show heading: set text(font: "Source Han Sans", weight: "bold")  // 黑体标题
// #show raw: set text(font: "Source Han Code JP")                      // 等宽代码字体

#show: simple-theme.with(aspect-ratio: "16-9", footer: [密码技术研究进展])

#title-slide[
  = 我们在密码技术研究上的进展
  #v(2em)

  主讲：23电子信息-向嘉豪

  #v(2em)
  #datetime.today().display()
]

== 目录

#text(size: 24pt)[
  - 密码研究背景
  - 密码研究热点
  - 论文书写投稿
]


= 密码研究背景

== Alice与Bob的通信困境

想象这样一个场景：#bluet[Alice]想要向#bluet[Bob]发送一条重要的消息

#pause

#align(center)[
  #cetz-canvas({
    import cetz.draw: *

    // Alice
    circle((-3, 0), radius: 1.2, name: "alice")
    content("alice", [#text(size: 16pt, fill: blue)[Alice]])

    // Bob
    circle((3, 0), radius: 1.2, name: "bob")
    content("bob", [#text(size: 16pt, fill: blue)[Bob]])

    // Message arrow
    line((-1.8, 0), (1.8, 0), mark: (end: ">"))
    content((0, 0.7), [#text(size: 14pt)["明天上午9点开会"]], anchor: "center")
  })
]

#pause

但是，在开放的网络环境中，这条消息面临着多重威胁...

== Eve的#redt[窃听威胁]

#redt[窃听者Eve]可能截获并读取Alice和Bob之间的通信

#pause

#align(center)[
  #cetz-canvas({
    import cetz.draw: *

    // Alice
    circle((-3, 0), radius: 1.0, name: "alice")
    content("alice", [#text(size: 14pt, fill: blue)[Alice]])

    // Bob
    circle((3, 0), radius: 1.0, name: "bob")
    content("bob", [#text(size: 14pt, fill: blue)[Bob]])

    // Eve (eavesdropper)
    circle((0, 2.5), radius: 1.0, name: "eve")
    content("eve", [#text(size: 14pt, fill: red)[Eve]])

    // Communication lines
    line((-2.0, 0), (2.0, 0), mark: (end: ">"))
    line((-1, 0.5), (-0.5, 1.5), stroke: red)
    line((1, 0.5), (0.5, 1.5), stroke: red)

    content((0, -0.7), [#text(size: 12pt)[明文传输]], anchor: "center")
  })
]

#pause

#align(center)[
  #redt[问题1：机密性丢失] - Eve可以读取所有通信内容
]

== 对称密码解决方案

Alice和Bob事先共享一个#bluet[密钥K]，使用相同密钥进行加密和解密

#pause

#align(center)[
  #cetz-canvas({
    import cetz.draw: *

    // Alice side
    rect((-5.5, 1.5), (-3.0, 3.0), name: "alice-box")
    content("alice-box", [#text(size: 14pt, fill: blue)[Alice]])

    // Bob side
    rect((3.0, 1.5), (5.5, 3.0), name: "bob-box")
    content("bob-box", [#text(size: 14pt, fill: blue)[Bob]])

    // Encryption/Decryption
    rect((-5.5, -1.0), (-3.0, 0.5), name: "encrypt")
    content("encrypt", [#text(size: 12pt)[加密 \ Enc(M,K)]])

    rect((3.0, -1.0), (5.5, 0.5), name: "decrypt")
    content("decrypt", [#text(size: 12pt)[解密 \ Dec(C,K)]])

    // Communication
    line((-3.0, 0), (3.0, 0), mark: (end: ">"))
    content((0, 0.5), [#text(size: 14pt)[密文C]], anchor: "center")

    // Key sharing (dotted line above)
    line((-4.0, 4.0), (4.0, 4.0), stroke: (dash: "dashed"))
    content((0, 4.5), [#text(size: 12pt)[预先共享密钥K]], anchor: "center")

    // Eve cannot read
    circle((0, -2.5), radius: 1.0, name: "eve2")
    content("eve2", [#text(size: 12pt, fill: red)[Eve]])
    line((-1.0, -0.5), (-0.5, -1.5), stroke: red)
    line((1.0, -0.5), (0.5, -1.5), stroke: red)
    content((0, -3.8), [#text(size: 12pt, fill: red)[无法解密]], anchor: "center")
  })
]


== Mallory的#redt[篡改威胁]

更危险的是，#redt[恶意攻击者Mallory]不仅能窃听，还能修改消息内容

#pause

#align(center)[
  #cetz-canvas({
    import cetz.draw: *

    // Alice
    circle((-4, 0), radius: 1.0, name: "alice")
    content("alice", [#text(size: 14pt, fill: blue)[Alice]])

    // Bob
    circle((4, 0), radius: 1.0, name: "bob")
    content("bob", [#text(size: 14pt, fill: blue)[Bob]])

    // Mallory (attacker)
    circle((0, 0), radius: 1.0, name: "mallory")
    content("mallory", [#text(size: 12pt, fill: red)[Mallory]])

    // Communication lines
    line((-3.0, 0), (-1.0, 0), mark: (end: ">"))
    line((1.0, 0), (3.0, 0), mark: (end: ">"))

    content((-2.0, 0.7), [#text(size: 12pt)["9点开会"]], anchor: "center")
    content((2.0, 0.7), [#text(size: 12pt, fill: red)["8点开会"]], anchor: "center")
    content((0, -1.5), [#text(size: 12pt, fill: red)[篡改消息]], anchor: "center")
  })
]

#pause

#align(center)[
  #redt[问题2：完整性丢失] - Mallory可以修改通信内容
]

== 杂凑函数解决方案

使用#bluet[哈希函数H]为消息生成"数字指纹"，接收方验证消息是否被篡改

#pause

#align(center)[
  #cetz-canvas({
    import cetz.draw: *

    // Alice side
    content((-3.5, 3.0), [#text(size: 14pt, fill: blue)[Alice]], anchor: "center")
    rect((-5.5, 1.0), (-1.5, 2.5), name: "msg-box")
    content("msg-box", [#text(size: 12pt)[消息M + H(M)]])

    // Bob side
    content((3.5, 3.0), [#text(size: 14pt, fill: blue)[Bob]], anchor: "center")
    rect((1.5, 1.0), (5.5, 2.5), name: "verify-box")
    content("verify-box", [#text(size: 12pt)[验证:H(M')?= H(M)]])

    // Communication
    line((-1.5, 1.75), (1.5, 1.75), mark: (end: ">"))

    // Mallory tries to tamper
    circle((0, -1.5), radius: 1.0, name: "mallory2")
    content("mallory2", [#text(size: 12pt, fill: red)[Mallory]])
    content((0, -2.8), [#text(size: 12pt, fill: red)[篡改被发现！]], anchor: "center")
  })
]



== #redt[身份伪造威胁]

Alice如何确认消息真的来自Bob？Bob如何确认消息真的来自Alice？

#pause

#align(center)[
  #cetz-canvas({
    import cetz.draw: *

    // Alice
    circle((-3, 1), radius: 0.8, name: "alice")
    content("alice", [#text(size: 12pt, fill: blue)[Alice]])

    // Bob
    circle((3, 1), radius: 0.8, name: "bob")
    content("bob", [#text(size: 12pt, fill: blue)[Bob]])

    // Fake Alice (impersonator)
    circle((-3, -1), radius: 0.8, name: "fake")
    content("fake", [#text(size: 10pt, fill: red)[假Alice]])

    // Messages
    line((-2.2, 1), (2.2, 1), mark: (end: ">"))
    line((-2.2, -1), (2.2, -1), mark: (end: ">"), stroke: red)

    content((0, 1.5), [#text(size: 10pt)[真实消息]], anchor: "center")
    content((0, -0.4), [#text(size: 10pt, fill: red)[伪造消息]], anchor: "center")
  })
]

#pause

#align(center)[
  #redt[问题3：身份认证缺失] - 无法验证消息发送方的真实身份
]

== 公钥密码解决方案

每个用户有一对密钥：#bluet[公钥]（公开）和#bluet[私钥]（保密）

#pause

#align(center)[
  #cetz-canvas({
    import cetz.draw: *

    // Alice
    rect((-5.5, 2.0), (-2.5, 3.5), name: "alice3")
    content("alice3", [#text(size: 12pt, fill: blue)[Alice]])
    content((-4.0, 1.2), [#text(size: 10pt)[私钥: SK_A \ 公钥: PK_A]], anchor: "center")

    // Bob
    rect((2.5, 2.0), (5.5, 3.5), name: "bob3")
    content("bob3", [#text(size: 12pt, fill: blue)[Bob]])
    content((4.0, 1.2), [#text(size: 10pt)[私钥: SK_B \ 公钥: PK_B]], anchor: "center")

    // Digital signature
    line((-2.5, 0.8), (2.5, 0.8), mark: (end: ">"))
    content((0, 1.3), [#text(size: 12pt)[消息 + 数字签名]], anchor: "center")
    content((0, 0.3), [#text(size: 12pt)[Sign(M, SK_A)]], anchor: "center")

    // Verification
    content((4.0, -0.3), [#text(size: 10pt)[验证: Verify(M, Sign, PK_A)]], anchor: "center")
  })
]

#pause

#bluet[应用]：数字签名、密钥交换、身份认证


== 密码技术类别

#align(center)[
  #table(
    columns: (1.5fr, 2fr, 2.5fr, 1.5fr),
    align: center,
    stroke: (thickness: 2pt, paint: blue),
    fill: (x, y) => if y == 0 { blue.lighten(80%) } else if calc.odd(y) { gray.lighten(90%) },

    [#text(size: 16pt, weight: "bold", fill: blue)[技术类型]],
    [#text(size: 16pt, weight: "bold", fill: blue)[解决问题]],
    [#text(size: 16pt, weight: "bold", fill: blue)[典型算法]],
    [#text(size: 16pt, weight: "bold", fill: blue)[应用场景]],

    [#text(size: 14pt, fill: red)[对称密码 \ #text(size: 12pt)[Symmetric Crypto]]],
    [#text(size: 14pt)[机密性保护 \ #text(size: 12pt)[Confidentiality]]],
    [#text(size: 12pt)[AES, DES \ GIFT, PRESENT]],
    [#text(size: 12pt)[数据加密 \ 通信保密]],

    [#text(size: 14pt, fill: red)[哈希函数 \ #text(size: 12pt)[Hash Functions]]],
    [#text(size: 14pt)[完整性验证 \ #text(size: 12pt)[Integrity]]],
    [#text(size: 12pt)[SHA-256, SHA-3 \ PHOTON, SPONGENT]],
    [#text(size: 12pt)[数字指纹 \ 数据校验]],

    [#text(size: 14pt, fill: red)[公钥密码 \ #text(size: 12pt)[Public Key Crypto]]],
    [#text(size: 14pt)[身份认证 \ #text(size: 12pt)[Authentication]]],
    [#text(size: 12pt)[RSA, ECC \ 数字签名算法]],
    [#text(size: 12pt)[数字签名 \ 密钥交换]],

    [#text(size: 14pt, fill: red)[其他技术 \ #text(size: 12pt)[Other Tech]]],
    [#text(size: 14pt)[随机性+协议 \ #text(size: 12pt)[Random & Protocols]]],
    [#text(size: 12pt)[PRNG, TLS \ 密钥协商协议]],
    [#text(size: 12pt)[安全协议 \ 随机生成]],
  )
]

== IoT环境下的密码学挑战

前面我们看到密码学为Alice和Bob提供了完整的安全解决方案，但在#redt[物联网环境]中面临新的挑战：

#pause

过去十年，物联网稳步发展，被纳入：
- 智能电网、智能城市、智能家庭
- 农业、健康、智能交通、交通监控等场景

#pagebreak()

#align(center)[
  #redt[2024年]：188亿台互联设备正在使用中（同比增长13%）

  #redt[2025年]：约270-309亿台设备（IoT Analytics）

  #redt[2030年预测]：约400亿台设备（GSMA Intelligence）
]

但是，IoT设备具有严格的资源限制：

#pause

- 计算能力、RAM大小、ROM大小
- 寄存器宽度、不同的实现环境等


== 传统密码 vs 轻量级密码

#align(center)[

  传统AES-128需要：#redt[2400+ GE] | IoT设备预算：#bluet[1000-2000 GE]

]

#pause

#align(center)[
  #grid(
    columns: 2,
    gutter: 40pt,
    [
      #align(center)[
        #bluet[传统密码算法]

        #v(0.5em)

        - AES (高安全)
        - RSA (强认证)
        - SHA-256 (可靠哈希)

        #v(0.5em)

        #redt[资源需求过高]
      ]
    ],
    [
      #align(center)[
        #bluet[轻量级密码算法]

        #v(0.5em)

        - GIFT, PRESENT (轻量分组密码)
        - ECC (轻量公钥密码)
        - PHOTON (轻量哈希)

        #v(0.5em)

        #greent[适配IoT约束]
      ]
    ],
  )
]

#pagebreak()

#align(center)[
  #redt[解决方案]：设计专门针对IoT设备资源约束的#bluet[轻量级密码算法]
]


#align(center)[
  #cetz-canvas({
    import cetz.draw: *

    circle((0, 0), radius: 2.5, name: "center")
    content("center", [#text(size: 14pt, fill: blue)[IoT设备密码挑战 \ #text(size: 12pt)[Cryptography Challenges]]])

    let items = (
      ("内存限制", "Small Memory"),
      ("实时响应", "Real-time "),
      ("计算能力", "Computing "),
      ("物理空间", "Physical Area"),
      ("电池功耗", "Battery Power"),
    )

    for (i, (chinese, english)) in items.enumerate() {
      let angle = i * 72deg - 90deg
      let pos = (4.5 * calc.cos(angle), 4.5 * calc.sin(angle))
      rect((pos.at(0) - 1.2, pos.at(1) - 0.6), (pos.at(0) + 1.2, pos.at(1) + 0.6), fill: red.lighten(80%), stroke: red)
      content(pos, [#text(size: 12pt, fill: red)[#chinese \ #text(size: 10pt)[#english]]], anchor: "center")
      line((2.3 * calc.cos(angle), 2.3 * calc.sin(angle)), (3.3 * calc.cos(angle), 3.3 * calc.sin(angle)), stroke: blue)
    }
  })
]

== 轻量级密码的标准化工作 - 早期发展

#align(left)[
  #bluet[1994年] Neecham等人提出描述简洁、实现简单的
  #redt[Tiny Encryption Algorithm (TEA)]

  #pause

  #bluet[2004年] 欧洲国家成立ECRYPT/eSTREAM项目：
  80bits密钥在受限硬件资源中的应用

  #pause

  #bluet[2012年] IEC发布29192《轻量级密码》标准系列

  #pause

  #bluet[2012年] IEC发布29167标准系列，至今仍在扩展

  #pause

  #bluet[2013年] NIST启动轻量级密码研究项目
]

== 轻量级密码的标准化工作 - 近期发展

#align(left)[
  #bluet[2017年] NIST发布轻量级密码调查联合报告NISTIR 8114

  #pause

  #bluet[2018年] NIST发布轻量级密码算法征集需求和评估标准通知

  #pause

  #bluet[2019年4月] NIST公布了前两轮候选算法筛选结果

  #pause

  #bluet[2021年3月] NIST宣布进入最终轮的10个轻量级密码算法

  #pause

  #bluet[2025年8月] NIST正式发布轻量级密码算法标准，
  选定#redt[Ascon算法族]作为#redt[NIST轻量级密码算法标准]。
]

== 设计规范与标准

根据这些轻量级分组密码算法的设计规范与标准，
轻量级分组密码在设计上应考虑以下：

#grid(
  columns: 2,
  gutter: 20pt,
  [
    1. #redt[安全强度]

    2. #redt[灵活性]

    3. #redt[多重功能下的低开销]

    4. #redt[密文扩展]
  ],
  [
    5. #redt[侧信道]


    6. #redt[相关密钥攻击以及其他一些基本的攻击方法]
  ],
)

= 密码研究热点

== 四类研究方法概述

当前轻量级密码学研究主要围绕以下四个热点方向展开：

#grid(
  columns: 2,
  gutter: 20pt,
  [
    1. #bluet[优化实现]

    #align(center)[
      #text(fill: red)[
        对已有的轻量级密码算法进行硬件优化实现
      ]
    ]

    2. #bluet[结构改进方法]

    #align(center)[
      #text(fill: red)[
        基于分组密码，对密码算法的结构或部件进行改进
      ]
    ]
  ],
  [
    3. #bluet[应用场景设计]

    #align(center)[
      #text(fill: red)[
        针对特定应用场景或需求进行设计的轻量级算法
      ]
    ]

    4. #bluet[量子计算]

    #align(center)[
      #text(fill: red)[
        面对量子计算威胁的后量子密码学研究
      ]
    ]
  ],
)

== 优化实现

*硬件优化实现*

针对FPGA、ASIC等硬件平台的优化实现研究

#redt[研究热点]：
- 面积-吞吐率权衡优化
- 串行/并行架构设计
- S盒硬件电路优化
- 低功耗设计技术

#pagebreak()

*软件优化实现*

针对嵌入式处理器、微控制器的软件优化研究

#redt[研究热点]：
- 位切片实现技术
- 指令级优化策略
- 寄存器分配优化
- 内存访问优化

#pagebreak()

*异构优化实现*

针对GPU、多核处理器的并行加速研究

#redt[研究热点]：
- GPU并行计算框架
- 内存层次结构利用
- 异构计算平台优化

== 优化实现 - CRAFT硬件案例

#align(center)[
  #text(fill: red)[
    以CRAFT算法为例的硬件优化实现
  ]
]

#bluet[以《Efficient implementations of CRAFT cipher for Internet of Things》为例]

#pause

针对CRAFT算法提出了#redt[3种新的硬件架构实现]。

#align(center)[
  实验量少，关键在论文的书写。

  只需进行#bluet[不同的硬件优化架构实现]，比较#bluet[硬件参数]。
]


== 结构改进方法

#align(center)[
  #text(fill: red)[
    基于分组密码，对密码算法的结构或部件进行改进
  ]
]

#grid(
  columns: 4,
  gutter: 10pt,
  [
    #align(center)[
      #bluet[Feistel结构]

      #cetz.canvas(length: 1.8cm, {
        import cetz.draw: *

        // Input
        rect((0, 4), (2, 4.5), fill: blue.lighten(80%), stroke: blue)
        content((1, 4.25), [明文], anchor: "center")

        // Split
        line((1, 4), (0.5, 3.5))
        line((1, 4), (1.5, 3.5))

        // L0, R0
        rect((0, 3), (1, 3.5), fill: gray.lighten(80%))
        content((0.5, 3.25), [L₀], anchor: "center")
        rect((1, 3), (2, 3.5), fill: gray.lighten(80%))
        content((1.5, 3.25), [R₀], anchor: "center")

        // Round function
        rect((2.2, 2.5), (3.2, 3), fill: red.lighten(80%), stroke: red)
        content((2.7, 2.75), [F], anchor: "center")
        line((1.5, 3), (2.2, 2.75))

        // Key
        rect((3.5, 2.5), (4.2, 3), fill: green.lighten(80%))
        content((3.85, 2.75), [k₁], anchor: "center")
        line((3.5, 2.75), (3.2, 2.75))

        // XOR
        circle((0.5, 2.25), radius: 0.15, stroke: black)
        content((0.5, 2.25), [⊕], anchor: "center")
        line((0.5, 3), (0.5, 2.4))
        line((2.7, 2.5), (0.65, 2.25))

        // L1, R1
        rect((0, 1.5), (1, 2), fill: gray.lighten(80%))
        content((0.5, 1.75), [L₁], anchor: "center")
        rect((1, 1.5), (2, 2), fill: gray.lighten(80%))
        content((1.5, 1.75), [R₁], anchor: "center")

        line((0.5, 2.1), (0.5, 2))
        line((1.5, 3), (1.5, 2))

        // Dots
        content((1, 1), [...], anchor: "center")
      })
    ]
  ],
  [
    #align(center)[
      #bluet[SPN结构]

      #cetz.canvas(length: 1.7cm, {
        import cetz.draw: *

        // Input
        rect((0, 4.5), (2, 5), fill: blue.lighten(80%), stroke: blue)
        content((1, 4.75), [明文], anchor: "center")

        // S-box layer
        rect((0, 3.8), (2, 4.3), fill: red.lighten(80%), stroke: red)
        content((1, 4.05), [S盒层], anchor: "center")
        line((1, 4.5), (1, 4.3))

        // P-box layer
        rect((0, 3.1), (2, 3.6), fill: green.lighten(80%), stroke: green)
        content((1, 3.35), [P盒层], anchor: "center")
        line((1, 3.8), (1, 3.6))

        // S-box layer
        rect((0, 2.4), (2, 2.9), fill: red.lighten(80%), stroke: red)
        content((1, 2.65), [S盒层], anchor: "center")
        line((1, 3.1), (1, 2.9))

        // P-box layer
        rect((0, 1.7), (2, 2.2), fill: green.lighten(80%), stroke: green)
        content((1, 1.95), [P盒层], anchor: "center")
        line((1, 2.4), (1, 2.2))

        // Output
        rect((0, 1), (2, 1.5), fill: blue.lighten(80%), stroke: blue)
        content((1, 1.25), [密文], anchor: "center")
        line((1, 1.7), (1, 1.5))
      })
    ]
  ],
  [
    #align(center)[
      #bluet[QTL结构]

      #cetz.canvas(length: 2cm, {
        import cetz.draw: *

        // Input
        rect((0, 3), (2, 3.4), fill: blue.lighten(80%), stroke: blue)
        content((1, 3.2), [明文], anchor: "center")

        // Quarter rounds
        rect((0, 2.4), (0.9, 2.8), fill: red.lighten(80%), stroke: red)
        content((0.45, 2.6), [Q₁], anchor: "center")
        rect((1.1, 2.4), (2, 2.8), fill: red.lighten(80%), stroke: red)
        content((1.55, 2.6), [Q₂], anchor: "center")

        line((0.5, 3), (0.45, 2.8))
        line((1.5, 3), (1.55, 2.8))

        // Twist layer
        rect((0, 1.8), (2, 2.2), fill: green.lighten(80%), stroke: green)
        content((1, 2), [Twist], anchor: "center")
        line((0.45, 2.4), (1, 2.2))
        line((1.55, 2.4), (1, 2.2))

        // Output
        rect((0, 1.2), (2, 1.6), fill: blue.lighten(80%), stroke: blue)
        content((1, 1.4), [密文], anchor: "center")
        line((1, 1.8), (1, 1.6))
      })
    ]
  ],
  [
    #align(center)[
      #bluet[ARX结构]

      #cetz.canvas(length: 2cm, {
        import cetz.draw: *

        // Input
        rect((0, 3), (2, 3.4), fill: blue.lighten(80%), stroke: blue)
        content((1, 3.2), [明文], anchor: "center")

        // Add operation
        rect((0, 2.4), (0.6, 2.8), fill: red.lighten(80%), stroke: red)
        content((0.3, 2.6), [+], anchor: "center")

        // Rotate operation
        rect((0.7, 2.4), (1.3, 2.8), fill: green.lighten(80%), stroke: green)
        content((1, 2.6), [≪], anchor: "center")

        // XOR operation
        rect((1.4, 2.4), (2, 2.8), fill: orange.lighten(80%), stroke: orange)
        content((1.7, 2.6), [⊕], anchor: "center")

        line((0.5, 3), (0.3, 2.8))
        line((1, 3), (1, 2.8))
        line((1.5, 3), (1.7, 2.8))

        // Multiple rounds indication
        content((1, 2.1), [...], anchor: "center")

        // Output
        rect((0, 1.5), (2, 1.9), fill: blue.lighten(80%), stroke: blue)
        content((1, 1.7), [密文], anchor: "center")
        line((1, 2.0), (1, 1.9))
      })
    ]
  ],
)

== 应用场景设计

#align(center)[
  #text(fill: red)[
    针对特定应用场景或者需求进行设计的轻量级分组密码算法
  ]
]

典型算法示例：

+ 面向软硬件灵活实现的LBlock算法
+ 专注低能耗指标设计的Midori算法
+ 基于低延迟理念设计的PRINCE算法
+ 面向IC打印的PRINTcipher算法

== 应用场景设计 - LBlock算法


#grid(
  columns: 2,
  gutter: 20pt,
  [
    #align(center)[
      #text(size: 16pt)[LBlock算法加密流程图]

      #cetz.canvas(length: 2cm, {
        import cetz.draw: *

        // 64-bit input split into X0, X1 (32-bit each)
        rect((0, 4), (1, 4.4), fill: blue.lighten(80%), stroke: blue)
        content((0.5, 4.2), text(size: 8pt, [X₀]), anchor: "center")
        rect((1.5, 4), (2.5, 4.4), fill: blue.lighten(80%), stroke: blue)
        content((2, 4.2), text(size: 8pt, [X₁]), anchor: "center")

        // Left line (X0 stays)
        line((0.5, 4), (0.5, 3.5))

        // Right rotation <<<8
        rect((1.5, 3.5), (2.5, 3.8), fill: green.lighten(80%), stroke: green)
        content((2, 3.65), text(size: 10pt, [≪8]), anchor: "center")
        line((2, 4), (2, 3.8))

        // Round function F
        rect((0, 2.8), (1, 3.2), fill: red.lighten(80%), stroke: red)
        content((0.5, 3), text(size: 8pt, [F]), anchor: "center")
        line((0.5, 3.5), (0.5, 3.2))

        // XOR operation
        circle((1.25, 2.5), radius: 0.1, stroke: black)
        content((1.25, 2.5), text(size: 10pt, [⊕]), anchor: "center")
        line((0.5, 2.8), (1.15, 2.5))
        line((2, 3.5), (1.35, 2.5))

        // Round output
        rect((0.75, 2), (1.75, 2.4), fill: gray.lighten(80%))
        content((1.25, 2.2), text(size: 10pt, [轮输出]), anchor: "center")
        line((1.25, 2.4), (1.25, 2.4))

        // 32 rounds indication
        content((1.25, 1.5), text(size: 8pt, [32轮]), anchor: "center")
      })
    ]
  ],
  [
    LBlock采用了#bluet[4位逐字排列]，使得算法不仅可以在硬件中廉价实现，而且可以在软件环境中廉价实现。

    #text()[
      - 硬件：需要1320GE，吞吐量200Kbps
      - 软件：8位微控制器，加密64位数据需要3955个时钟周期
      - 算法每一轮只使用一半数据，另一半使用简单移位
      - 密钥调度以流密码方式设计
    ]
  ],
)

== 应用场景设计 - Midori算法 #bluet[低能耗]

#grid(
  columns: 2,
  gutter: 20pt,
  [
    #text()[
      + 列混淆使用4×4几乎MDS二进制矩阵，在面积和信号延迟方面比4×4 MDS矩阵更有效。

      + 使用了一个轻量级、小延迟的4位S-box。该S盒中的信号延迟分别是PRINCE和PRESENT的1.5倍和2倍。

      + Midori算法的加密和解密功能相互转换时，只需要通过在电路中的小调整就可以达到加解密一致。
    ]
  ],
  [
    #align(center)[
      #text(size: 16pt)[Midori算法加密流程图]

      #cetz.canvas(length: 1.5cm, {
        import cetz.draw: *

        // Input
        rect((0, 5), (2, 5.4), fill: blue.lighten(80%), stroke: blue)
        content((1, 5.2), text(size: 8pt, [明文]), anchor: "center")

        // Whitening key addition
        rect((0, 4.4), (2, 4.8), fill: green.lighten(80%), stroke: green)
        content((1, 4.6), text(size: 10pt, [KA(WK)]), anchor: "center")
        line((1, 5), (1, 4.8))

        // Round structure (repeated 15 times)
        rect((0, 3.8), (2, 4.2), fill: red.lighten(80%), stroke: red)
        content((1, 4), text(size: 10pt, [SB]), anchor: "center")
        line((1, 4.4), (1, 4.2))

        rect((0, 3.2), (2, 3.6), fill: orange.lighten(80%), stroke: orange)
        content((1, 3.4), text(size: 10pt, [SC]), anchor: "center")
        line((1, 3.8), (1, 3.6))

        rect((0, 2.6), (2, 3), fill: purple.lighten(80%), stroke: purple)
        content((1, 2.8), text(size: 10pt, [MC]), anchor: "center")
        line((1, 3.2), (1, 3))

        rect((0, 2), (2, 2.4), fill: green.lighten(80%), stroke: green)
        content((1, 2.2), text(size: 10pt, [KA(RKᵢ)]), anchor: "center")
        line((1, 2.6), (1, 2.4))

        // Indication of 15 rounds
        content((2.5, 3.1), text(size: 8pt, [15轮]), anchor: "center", angle: -90deg)

        // Final round
        rect((0, 1.4), (2, 1.8), fill: red.lighten(80%), stroke: red)
        content((1, 1.6), text(size: 10pt, [SB]), anchor: "center")
        line((1, 2), (1, 1.8))

        // Final whitening
        rect((0, 0.8), (2, 1.2), fill: green.lighten(80%), stroke: green)
        content((1, 1), text(size: 10pt, [KA(WK)]), anchor: "center")
        line((1, 1.4), (1, 1.2))

        // Output
        rect((0, 0.2), (2, 0.6), fill: blue.lighten(80%), stroke: blue)
        content((1, 0.4), text(size: 8pt, [密文]), anchor: "center")
        line((1, 0.8), (1, 0.6))
      })
    ]
  ],
)

== 应用场景设计 - PRINCE算法 #bluet[低延迟]

#grid(
  columns: 2,
  gutter: 20pt,
  [
    #text()[
      PRINCE算法低延迟主要的方式是#bluet[轮数尽可能地少]，轮函数中的部件尽量采用#bluet[低延迟]。

      因此，PRINCE的轮数只有#redt[11轮]（5+1+5），还采用了一个#bluet[几乎MDS矩阵]，这样有助于为各种类型攻击提供更好边界，进而可以允许减少轮数，从而减少延迟。


      除此之外，PRINCE的加密结构也很新颖，具有#redt[α-反射性质]：
    ]
  ],
  [
    #align(center)[
      #text(size: 16pt)[PRINCE算法加密流程图]

      #cetz.canvas(length: 1.8cm, {
        import cetz.draw: *

        // Input
        rect((0, 6), (2, 6.4), fill: blue.lighten(80%), stroke: blue)
        content((1, 6.2), text(size: 8pt, [明文]), anchor: "center")

        // Pre-whitening with k0 XOR k1
        rect((0, 5.4), (2, 5.8), fill: green.lighten(80%), stroke: green)
        content((1, 5.6), text(size: 10pt, [k₀ ⊕ k₁]), anchor: "center")
        line((1, 6), (1, 5.8))

        // Forward rounds (5 rounds)
        rect((0, 4.8), (2, 5.2), fill: red.lighten(80%), stroke: red)
        content((1, 5), text(size: 10pt, [前向轮]), anchor: "center")
        line((1, 5.4), (1, 5.2))

        content((2.3, 5), text(size: 6pt, [5轮]), anchor: "center")

        // Middle round (special)
        rect((0, 4.2), (2, 4.6), fill: orange.lighten(80%), stroke: orange)
        content((1, 4.4), text(size: 10pt, [中间轮]), anchor: "center")
        line((1, 4.8), (1, 4.6))

        // Backward rounds (5 rounds) - involutory property
        rect((0, 3.6), (2, 4), fill: purple.lighten(80%), stroke: purple)
        content((1, 3.8), text(size: 10pt, [后向轮]), anchor: "center")
        line((1, 4.2), (1, 4))

        content((2.3, 3.8), text(size: 6pt, [5轮]), anchor: "center")

        // Post-whitening with k0 XOR k1'
        rect((0, 3), (2, 3.4), fill: green.lighten(80%), stroke: green)
        content((1, 3.2), text(size: 10pt, [k₀ ⊕ k₁']), anchor: "center")
        line((1, 3.6), (1, 3.4))

        // Output
        rect((0, 2.4), (2, 2.8), fill: blue.lighten(80%), stroke: blue)
        content((1, 2.6), text(size: 8pt, [密文]), anchor: "center")
        line((1, 3), (1, 2.8))

        // Alpha reflection property indication
        content((0, 1.8), text(size: 6pt, [α-反射性质]), anchor: "center")
        content((0, 1.5), text(size: 6pt, [解密=加密]), anchor: "center")
      })
    ]
  ],
)


== 应用场景设计 - PRINTcipher算法


由于IC打印中使用到的#bluet[电子产品代码（EPC）]的长度为96位，因此PRINTcipher使用的明文长度为#redt[48bit和96bit]两个版本，密钥长度为#redt[160bit]，两个版本分别对应的轮数为#redt[48，96轮]。

常规的IC为了节省开销，一般要求IC中的使用密钥不进行更改，因此，PRINTcipher算法的#bluet[没有密钥扩展部分]，设计者通过使用一种排列方法，使得算法可以根据不同的密钥具有不同的加密流程。

== 密码组件 - 侧重低延迟或侧重轻量的S盒构造方法

目前，为了能快速优化4×4的S盒，研究人员主要采用#bluet[自动化的方法搜索S盒]，
具体可以细分为两个方向。

#align(center)[
  #text(fill: red)[
    方向一：首先获得具有良好密码特性的S盒，然后通过某种方法优化S盒的硬件逻辑电路
  ]
]

#text()[
  Jean等人应用#bluet[LIGHTER]搜索给定4×4 S盒的面积优化实现。但LIGHTER的一个缺失考虑因素是实现延迟的度量。Stoffelen将寻找最佳位片实现的整个问题建模为SAT求解器可以解决的问题。
]

#pagebreak()

#align(center)[
  #text(fill: red)[
    方向二：首先从硬件逻辑层创建紧凑的S盒，然后检查其密码特性
  ]
]

#text()[
  Watanabe等人使用对#bluet[基本可逆函数的迭代]来生成初始S盒集，然后将约束添加到初始S盒集中以获得目标S盒。

  Guo等人提出了一种在#bluet[ASIC中寻找电路深度优化]的实现的方法。本质上，该工具首先给定S盒和每个单元操作的成本，作为初始S盒集。然后，输出查询结果和四个坐标的深度中的最大值。
]

== 密码组件 - 侧重低延迟和比特切片的线性矩阵构造方法

为了快速找到性能优良的矩阵，研究人员主要采用#bluet[启发式算法搜索矩阵]，
具体可以细分为三个方向。

#text(fill: red)[方向一：] 首先搜索一个性能好的矩阵，然后再搜索该矩阵的良好硬件实现

#text(fill: red)[方向二：] 首先从逻辑层搜索可行的矩阵构造，然后检查其矩阵分支数特性

#text(fill: red)[方向三：] 首先确定轻量的小规格矩阵，然后通过递归、子域构造的方法构造性能良好的大规格矩阵

== 量子计算 - 密码技术

#align(center)[
  #text(fill: red)[
    面对量子计算威胁的后量子密码学研究
  ]
]

随着量子计算技术的快速发展，传统的RSA、ECC等公钥密码算法面临被量子计算机破解的威胁。
#bluet[2024年Google的Willow芯片]和#bluet[2025年Microsoft的Majorana 1]等量子计算突破，
使得后量子密码学成为当前最热门的研究方向。

#pagebreak()

#align(center)[
  #text(fill: blue)[
    后量子密码技术路线分类
  ]
]

#grid(
  columns: 5,
  gutter: 8pt,
  [
    #align(center)[
      #bluet[格密码]

      #cetz.canvas(length: 1.8cm, {
        import cetz.draw: *

        // Grid structure representing lattice
        for i in range(4) {
          for j in range(4) {
            circle((i * 0.5, j * 0.5), radius: 0.05, fill: blue, stroke: blue)
          }
        }

        // Lattice vectors
        line((0, 0), (1.5, 0.5), stroke: red + 2pt)
        line((0, 0), (0.5, 1.5), stroke: red + 2pt)

        content((0.75, 2), text(size: 9pt, [CRYSTALS]), anchor: "center")
        content((0.75, 1.8), text(size: 8pt, [Kyber/Dilithium]), anchor: "center")
      })
    ]
  ],
  [
    #align(center)[
      #bluet[编码理论]

      #cetz.canvas(length: 1.8cm, {
        import cetz.draw: *

        // Error correction visualization
        rect((0, 1.5), (2, 2), fill: green.lighten(80%), stroke: green)
        content((1, 1.75), text(size: 8pt, [信息位]), anchor: "center")

        rect((0, 1), (2, 1.4), fill: red.lighten(80%), stroke: red)
        content((1, 1.2), text(size: 8pt, [校验位]), anchor: "center")

        rect((0, 0.5), (2, 0.9), fill: orange.lighten(80%), stroke: orange)
        content((1, 0.7), text(size: 8pt, [错误纠正]), anchor: "center")

        content((1, 0.2), text(size: 9pt, [McEliece]), anchor: "center")
      })
    ]
  ],
  [
    #align(center)[
      #bluet[多变量]

      #cetz.canvas(length: 1.8cm, {
        import cetz.draw: *

        // Multivariate polynomial system
        content((1, 1.8), text(size: 9pt, [f₁(x₁,...,xₙ)=0]), anchor: "center")
        content((1, 1.5), text(size: 9pt, [f₂(x₁,...,xₙ)=0]), anchor: "center")
        content((1, 1.2), text(size: 9pt, [...]), anchor: "center")
        content((1, 0.9), text(size: 9pt, [fₘ(x₁,...,xₙ)=0]), anchor: "center")

        content((1, 0.5), text(size: 11pt, [Rainbow]), anchor: "center")
        content((1, 0.3), text(size: 11pt, [GeMSS]), anchor: "center")
      })
    ]
  ],
  [
    #align(center)[
      #bluet[哈希函数]

      #cetz.canvas(length: 1.8cm, {
        import cetz.draw: *

        // Hash tree structure
        circle((1, 1.8), radius: 0.1, fill: blue)
        circle((0.5, 1.4), radius: 0.08, fill: green)
        circle((1.5, 1.4), radius: 0.08, fill: green)
        circle((0.25, 1), radius: 0.06, fill: red)
        circle((0.75, 1), radius: 0.06, fill: red)
        circle((1.25, 1), radius: 0.06, fill: red)
        circle((1.75, 1), radius: 0.06, fill: red)

        line((1, 1.7), (0.5, 1.48))
        line((1, 1.7), (1.5, 1.48))
        line((0.5, 1.32), (0.25, 1.06))
        line((0.5, 1.32), (0.75, 1.06))
        line((1.5, 1.32), (1.25, 1.06))
        line((1.5, 1.32), (1.75, 1.06))

        content((1, 0.6), text(size: 11pt, [SPHINCS+]), anchor: "center")
      })
    ]
  ],
  [
    #align(center)[
      #bluet[同源理论]

      #cetz.canvas(length: 1.8cm, {
        import cetz.draw: *

        // Isogeny between elliptic curves
        circle((0.5, 1.5), radius: 0.3, stroke: blue + 1pt, fill: none)
        circle((1.5, 1.5), radius: 0.3, stroke: red + 1pt, fill: none)

        // Isogeny arrow
        line((0.8, 1.5), (1.2, 1.5), stroke: green + 2pt)
        content((1, 1.6), text(size: 12pt, [φ]), anchor: "center")

        content((0.5, 1), text(size: 12pt, [E₁]), anchor: "center")
        content((1.5, 1), text(size: 12pt, [E₂]), anchor: "center")

        content((1, 0.6), text(size: 11pt, [SIKE]), anchor: "center")
        content((1, 0.4), text(size: 10pt, [(已破解)]), anchor: "center")
      })
    ]
  ],
)


== 量子计算 - NIST标准化算法（2024-2025）

#grid(
  columns: 2,
  gutter: 20pt,
  [
    #text()[
      - #bluet[ML-KEM]（基于CRYSTALS-Kyber）
        - 密钥封装机制

      - #bluet[ML-DSA]（基于CRYSTALS-Dilithium）
        - 数字签名算法

      - #bluet[SLH-DSA]（基于SPHINCS+）
        - 无状态哈希签名
    ]
  ],
  [
    #align(center)[
      #text(size: 14pt)[量子威胁时间线]

      #cetz.canvas(length: 4cm, {
        import cetz.draw: *

        // Timeline
        line((0, 2), (0, 0.2), stroke: black + 2pt)

        // 2024
        line((-0.1, 1.8), (0.1, 1.8), stroke: blue + 2pt)
        content((0.8, 1.8), text(size: 10pt, [2024: NIST标准发布]), anchor: "west")

        // 2025
        line((-0.1, 1.5), (0.1, 1.5), stroke: green + 2pt)
        content((0.8, 1.5), text(size: 10pt, [2025: HQC算法标准化]), anchor: "west")

        // 2029
        line((-0.1, 1.2), (0.1, 1.2), stroke: orange + 2pt)
        content((0.8, 1.2), text(size: 10pt, [2029: 核心服务采用]), anchor: "west")

        // 2034
        line((-0.1, 0.9), (0.1, 0.9), stroke: red + 2pt)
        content((0.8, 0.9), text(size: 10pt, [2034: 17-34%破解概率]), anchor: "west")

        // 2035
        line((-0.1, 0.6), (0.1, 0.6), stroke: purple + 2pt)
        content((0.8, 0.6), text(size: 10pt, [2035: 美国强制采用]), anchor: "west")

        content((0, 0.3), text(size: 12pt, [量子威胁迫近]), anchor: "center")
      })
    ]
  ],
)


== 量子计算 - 产业应用现状与挑战

#text()[
  *技术突破*：
  - Google Willow芯片：减少量子噪声和错误
  - 理论预测：100万量子比特可在1周内破解RSA-2048
  - 中国"本源悟空"装备PQC"抗量子攻击护盾"

  *应用挑战*：
  - 算法性能开销：后量子算法密钥长度和计算复杂度显著增加
  - 迁移复杂性：需要重新设计整个密码基础设施
  - 标准不统一：不同应用场景需要不同的后量子算法
  - 人才短缺：后量子密码学专业人才严重不足
]

= 论文书写及投稿

== 研究热点锁定 - 科学问题寻找

#align(center)[
  #text(fill: red)[
    如何寻找科学问题：
  ]
]

(1) 在亲身研究和实践中，遇到的问题（#redt[主要方法]）。

(2) 通过读文献，察觉到前人未解决的问题或未意识到的问题。

(3) 借鉴"它山之石"，有了攻克悬而未决老问题的奇思妙想。

== 研究热点锁定 - 读论文

#align(center)[
  #text(fill: red)[
    如何在入门阶段快速锁定研究热点：
  ]
]


#bluet[步骤1] 看综述论文。
- 近一年的博士、硕士大论文综述部分。
- 近一年的高水平期刊收录的综述论文。

#bluet[步骤2] 看相关领域顶会顶刊收录的论文（近两年）。


== 论文阅读概述

#align(center)[
  #text(fill: red)[
    好的创意来自于好的论文阅读。
  ]
]


怎样寻找好论文以及阅读论文：


#grid(
  columns: 3,
  gutter: 20pt,
  [
    #align(center)[
      #bluet[下载相关论文集]
    ]
  ],
  [
    #align(center)[
      #bluet[三步阅读法]
    ]
  ],
  [
    #align(center)[
      #bluet[文献管理]
    ]
  ],
)


== 论文阅读 - 论文集下载


主要下载近3年的文献，可以通过以下几种方式获得论文：

(1) 综述论文中的参考文献（入门时使用）。

(2) 熊猫(谷歌)学术或三大数据库搜索关键字。

下载论文可以使用：

#text()[
  - (1) 熊猫学术（https://panda321.com/）
  - (2) SPIS学术下载（http://spis.hnlat.com/）
  - (3) 衡阳师范学院文献互助群（572761699）
]


== 论文阅读 - 三步阅读法 - 粗读


#align(center)[
  #text(fill: red)[
    第一步（粗读）
  ]
]


(1) 仔细阅读标题、摘要与引言。

(2) 细读每个章节与子章节的标题（忽略其他的内容）。

(3) 总结。

(4) 浏览参考文献，标记自己已经读过的。


#pagebreak()


第一步完成后对论文将会有如下认知，或者提出一些问题：

(1) #bluet[文章类别]：这篇文章是什么种类的？轻量级分组密码？分组密码？优化？密码分析？侧信道分析？

(2) #bluet[文章内容]：有哪些其他相关文章？问题分析基于哪个理论？

(3) #bluet[正确性]：文中的假设或提出的理论是否合理正确？

(4) #bluet[贡献]：文章的主要贡献是什么？#bluet[清晰性]：文章的写作是否足够好？


== 论文阅读 - 三步阅读法 - 细读

#align(center)[
  #text(fill: red)[
    第二步（细读）
  ]
]

(1) 细心阅读图、表

(2) 记得标记相关的未读的参考文献（这是一种非常好的了解论文背景的方法）

在第二步中，更细心地读文章，特别是背景，可忽略一些细节如理论的证明（可以作一些注释）。


#pagebreak()

完成第二步，论文中仍然会有许多你不理解的地方，比如一些细分领域的背景理解不够或是证明的理论或实验不能理解。这时可以：

(a) 把这篇论文先放边。

(b) 稍后再拿起来认真阅读，特别注意背景部分。

(c) 直接进入第三步。


== 论文阅读 - 三步阅读法 - 实验复现


#align(center)[
  #text(fill: red)[
    第三步（实验复现）
  ]
]


为了完全地理解这篇文章，并能够在此基础上进行改进，需要做的最关键的步骤是对论文实验的重构，即#redt[站在作者的角度，重复他的工作]。


== 文献管理


每读一篇好论文，需要对其进行管理，这有两个好处，一是可以方便再调出来看，二是引用的时候非常方便。主要的管理方法：

(1) 建立自顶向下建立文件夹。大方向→小方向→好论文。论文的文件夹命名（年份+名字+期刊/会议）

(2) 画思维导图

(3) 文件管理软件（#bluet[Mendeley Desktop]，#bluet[JabRef]）


== 写论文概述


通过前面的论文阅读与文献收集管理，此时应该内心会产生一些想法和思路，先在理论上对自己提出的想法进行推论验证。然后开始设计实验，由于前期做了复现论文的准备，因此在实验上会相对比较顺利。


== 论文结构


在完成最初的想法构思或创新的方法后，在理论上对方法进行抽象，实验验证方法的正确性与优势，开始撰写论文。一般，实证型论文的结构包括：

#grid(
  columns: 2,
  gutter: 20pt,
  [
    (1) 题目/摘要

    (2) 引言

    (3) 方法

    (4) 实验结果和讨论
  ],
  [
    (5) 结论

    (6) 致谢

    (7) 参考文献
  ],
)

== 摘要 五个语步

摘要部分通常涉及（或者说就是）五个语步：

#bluet[语步1]：概述研究现状或主要问题。

#bluet[语步2]：介绍本研究的内容和目的。

#bluet[语步3]：介绍研究方法。

#bluet[语步4]：指出主要研究发现和结果。

#bluet[语步5]：总述结论、研究价值、应用前景或建议。


== 引言 三个语步


通常引言部分有三个语步：

#bluet[语步1]：介绍研究领域。突出研究话题的意义、价值和重要性，回顾相关文献。

#bluet[语步2]：确定研究动机。指出先前研究的不足或扩展现有知识。

#bluet[语步3]：描述当前研究。提出研究目的、研究性质或研究问题，或宣布重要的研究结果，明确研究的意义，概括全文的框架结构。

== 方法部分语步

方法部分一般如下：

#bluet[语步1]：介绍研究目的、研究问题或假设。

#bluet[语步2]：介绍研究步骤。

#bluet[语步3]：介绍数据分析方法。


== 结果讨论语步

实验结果和讨论部分一般如下：

#bluet[语步1]：提供背景信息。实验环境，实验参数设置。

#bluet[语步2]：以文本形式呈现研究结果，并进行讨论（一般使用对比法）

#bluet[语步3]：以非文本形式（如图、表等）呈现研究结果。

== 结论部分语步

结论部分通常是文章正文最后一节，说明研究的意义或应用前景。

#bluet[语步1]：概括当前的研究。回顾研究动机、目的、主要的研究结果。

#bluet[语步2]：评价研究结果的价值。

#bluet[语步3]：讨论研究的不足之处。指出研究存在的问题并给予解释。（这一步通常不写）

#bluet[语步4]：对研究做出推论，指出未来的研究启示及方向。

== 写作工具

写论文过程中一些非常有用的工具：

#bluet[文字处理]：word

#bluet[文字排版]：latex: TeX live + TeX studio、CTeX、VsCode等

#bluet[实验绘图]：matlab、python、Origin等

#bluet[结构绘图]：Visio、smartdraw、Drawio等


== 投稿过程

论文初稿完成后，进行修改与优化，下一个步骤便是进行投稿，这一步骤涉及：

(1) #bluet[期刊选择]。
#text()[
  借助LetPub网站查询期刊相关信息。（中科院分区，影响因子，年文章数，投稿周期，网友经验等）
  https://www.letpub.com.cn/
  期刊官网。了解期刊投稿范围和要求。
]

(2) 提交相关文档。

== 审稿返修

#align(center)[
  #text(fill: red)[
    如何回复审稿人意见
  ]
]

+ 所有问题必须逐条回答。如果存在一段审稿意见多个问题，进行拆分回复。回复格式一般为：感谢+回复+附上手稿中的修改部分。
+ 尽量满足意见中需要补充的实验。
+ 满足不了的也不要回避，说明不能做的合理理由。
+ 审稿人推荐的文献一定要引用，并讨论透彻。
+ 回复审稿人关于稿件的修改一定要全部使用现在完成时，不要使用一般过去时。


== 常见审稿人意见


+ 文章格式错误、拼写错误、图表标错、语句有歧义等等。

+ 要求加文献。仔细阅读审稿人推荐的参考文献，在意见回复中要讨论透彻。

+ 要求补充或修改手稿的内容。比如引言增加相关文献讨论，摘要或总结修改。要求语法修改。要求调整说法。

+ 质疑内容的创新性。感谢审稿人的评论+阐述论文的创新点和优势，适当引用顶会顶刊的论文做依据。#bluet[建议补充实验]。

== 审稿意见回复

#text()[
  - #redt[做这个实验]。同意审稿人的观点+新的实验数
  - #redt[没有实验条件]，或者不能在短时期内做这个实验。看看现有数据能不能同样说明科学问题，也可以补充其他相关实验数据辅助说明，实在不行，可以查阅文献（最好是顶会或顶刊），告诉审稿人其他文献也存在同样的情况。
  - #redt[觉得没有必要补实验]。这个时候需要给出自己的理由。最好罗列一些证据，或者引用其它文献（最好是顶会或顶刊）来支撑自己的观点。
]



= Q&A


#grid(
  columns: 2,
  gutter: 40pt,
  [
    #align(center)[

      #image("fig/wechat.jpg", width: 60%)

    ]
  ],
  [
    #align(center)[

      #image("fig/bilibili.jpg", width: 60%)

    ]
  ],
)

