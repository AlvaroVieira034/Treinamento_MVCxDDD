object FrmMostraPedido: TFrmMostraPedido
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Pesquisa de Pedidos'
  ClientHeight = 530
  ClientWidth = 763
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label13: TLabel
    Left = 56
    Top = 133
    Width = 64
    Height = 23
    Caption = 'Cidade:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label14: TLabel
    Left = 126
    Top = 133
    Width = 111
    Height = 23
    Caption = 'Jos'#233' da Sillva'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label15: TLabel
    Left = 579
    Top = 132
    Width = 29
    Height = 23
    Caption = 'UF:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label16: TLabel
    Left = 617
    Top = 132
    Width = 28
    Height = 23
    Caption = 'MG'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label17: TLabel
    Left = 56
    Top = 126
    Width = 64
    Height = 23
    Caption = 'Cidade:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label18: TLabel
    Left = 126
    Top = 126
    Width = 111
    Height = 23
    Caption = 'Jos'#233' da Sillva'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label19: TLabel
    Left = 579
    Top = 126
    Width = 29
    Height = 23
    Caption = 'UF:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label20: TLabel
    Left = 614
    Top = 126
    Width = 28
    Height = 23
    Caption = 'MG'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object PnlDados: TPanel
    Left = 0
    Top = 0
    Width = 763
    Height = 555
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = -6
    ExplicitWidth = 747
    ExplicitHeight = 369
    DesignSize = (
      763
      555)
    object LblPedido: TLabel
      Left = 554
      Top = 14
      Width = 102
      Height = 25
      Caption = 'Pedido No:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblDataPedido: TLabel
      Left = 578
      Top = 39
      Width = 76
      Height = 18
      Caption = '10/10/2025'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblCliente: TLabel
      Left = 43
      Top = 71
      Width = 63
      Height = 23
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblDescricao: TLabel
      Left = 257
      Top = 180
      Width = 218
      Height = 27
      Caption = 'Descri'#231#227'o do Pedido'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Britannic Bold'
      Font.Style = []
      ParentFont = False
    end
    object LblNroPedido: TLabel
      Left = 664
      Top = 14
      Width = 11
      Height = 25
      Caption = '1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblEndCompleto: TLabel
      Left = 112
      Top = 94
      Width = 111
      Height = 23
      Caption = 'Jos'#233' da Sillva'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblCidade: TLabel
      Left = 42
      Top = 117
      Width = 64
      Height = 23
      Caption = 'Cidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblEndereco: TLabel
      Left = 20
      Top = 94
      Width = 86
      Height = 23
      Caption = 'Endere'#231'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblNomeCidade: TLabel
      Left = 112
      Top = 118
      Width = 111
      Height = 23
      Caption = 'Jos'#233' da Sillva'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblUF: TLabel
      Left = 571
      Top = 118
      Width = 29
      Height = 23
      Caption = 'UF:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblNomeUF: TLabel
      Left = 606
      Top = 118
      Width = 28
      Height = 23
      Caption = 'MG'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblCNPJ: TLabel
      Left = 57
      Top = 143
      Width = 49
      Height = 23
      Caption = 'CNPJ:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblNroCNPJ: TLabel
      Left = 112
      Top = 143
      Width = 42
      Height = 23
      Caption = 'CNPJ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblVlrTotal: TLabel
      Left = 614
      Top = 487
      Width = 96
      Height = 23
      Alignment = taRightJustify
      Caption = '9999999,99'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblTotal: TLabel
      Left = 427
      Top = 487
      Width = 181
      Height = 23
      Caption = 'Valor total do pedido:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblFone: TLabel
      Left = 552
      Top = 143
      Width = 48
      Height = 23
      Caption = 'Fone:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblNroFone: TLabel
      Left = 606
      Top = 143
      Width = 42
      Height = 23
      Caption = 'CNPJ'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object LblNomeCliente: TLabel
      Left = 112
      Top = 71
      Width = 111
      Height = 23
      Caption = 'Jos'#233' da Sillva'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object DbGridItensPedido: TDBGrid
      Left = 16
      Top = 220
      Width = 731
      Height = 253
      Anchors = [akLeft, akRight, akBottom]
      DataSource = DsPedidoItem
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Century Gothic'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -19
      TitleFont.Name = 'Times New Roman'
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'DES_DESCRICAO'
          Title.Caption = 'Produto'
          Width = 323
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'VAL_QUANTIDADE'
          Title.Alignment = taCenter
          Title.Caption = 'Quantidade'
          Width = 108
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VAL_PRECOUNITARIO'
          Title.Alignment = taCenter
          Title.Caption = 'Pre'#231'o Unit'#225'rio'
          Width = 135
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VAL_TOTALITEM'
          Title.Alignment = taCenter
          Title.Caption = 'Valor Total'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ID_VENDA'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'COD_VENDA'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'COD_PRODUTO'
          Visible = False
        end>
    end
    object BtnFechar: TBitBtn
      Left = 16
      Top = 15
      Width = 31
      Height = 33
      Glyph.Data = {
        360C0000424D360C000000000000360000002800000020000000200000000100
        180000000000000C0000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFCFCFCF6F6F6EFEFEFEAEAEAEEEEEEF9F9F9F9F9F9EEEEEE
        E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
        E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
        E9E9E9E9E9E8E8E8E3E3E3D7D7D7C9C9C9BFBFBFCDCDCDEEEEEEF4F4F4DDDDDD
        D2D2D2D2D2D2D2D2D2D2D2D2D2D2D2CDCDCDC2C2C2BCBCBCBCBCBCBCBCBCBCBC
        BCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBCBC
        BCBCBCBCBCBCBCBCB6B7B9869CAE658AA74B7CA469A6DAE9E9E9F9F9F95C5C5C
        5C5C5C5C5C5C5C5C5C5C5C5C5C5C5C5D5C5A5D5B595C5A5A5A5A5A5A5A5B5A5A
        5B5A5A5B5A5A5B5A5A5B5A5A5B5A5A5B5A5A5B5A5A5B5A5A5B5A5A5A5C595757
        6570536E834E7B9F4C7FAA4C7FA94B7EA85081A867A4D8E9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E9386CA1706B666D6B696D6B6A6D6B
        6A6D6B6A6D6B6A6D6B6A6D6B6A6D6B6A6D6B6A6D6B6A6D6B6A6D6A686F68644A
        86B54C83AE4D82AC4D81AA4D81AA4C80A95786AC66A3D6E9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E93C6B9C6D67616A67656967666967
        666967666967666967666967666967666967666967666967666A67656C645F4B
        85B44E83AE4E82AC4E82AC4E82AC4C80AB5B8BB164A1D3E9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E93D6B9C6B66606866646766656766
        6567666567666567666567666567666567666567666567666567666469635D4B
        86B64E83AF4E83AE4E83AE4E83AE4C81AD628FB3629FD2E9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E93F6C9D6A635E6764626664636664
        6366646366646366646366646366646366646366646366646366646269615B4D
        87B74F84B04F84AF4F84AF4F84AF4D82AD6694B8619DCFE9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFBFBFBF2F2F2DADADA416D9F68605C6462606462616462
        6164626164626164626164626164626164626164626164626164615F665E594E
        8AB95087B25086B15086B15086B14D84AF6C99BA609CCEE9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFCFCFCEBEBEBD1D1D1BABABA446DA4665F5B62615F6261606261
        6062616062616062616062616062616062616062616062616062605F645D574F
        8BBC5188B55187B35187B35187B34E85B1729CBF5E9ACCE9E9E9FFFFFFFFFFFF
        FFFFFFFCFCFCEBEBEBCDCDCD3C9A6E009246476CA7655D59615F5D615F5E615F
        5E615F5E615F5E615F5E615F5E615F5E615F5E615F5E615F5E615E5C635B5550
        8CBD5289B65288B45288B45288B44F86B378A1C35C98CAE9E9E9FFFFFFFFFFFF
        FCFCFCEBEBEBCDCDCD3E986E00C885008F45486CA8645A57615C5B605D5C5F5D
        5C5F5D5C5F5D5C5F5D5C5F5D5C5F5D5C5F5D5C5F5D5C5F5D5C5F5C5A60585352
        8EBF538AB85389B65389B65389B64D82AD7CA5C65B96C8E9E9E9FFFFFFFCFCFC
        EBEBEBCDCDCD3E976D00C08000E5A5008A434E6AAA69535765555A62575B5F5A
        5B5D5B5B5D5B5B5D5B5B5D5B5B5D5B5B5D5B5B5D5B5B5D5B5B5D5A595E565153
        90C1548CB9548BB7548BB7548BB7497BA282AACA5A95C5E9E9E9FBFBFBEBEBEB
        CDCDCD3E986D00BC8100DBA000DCA1008440008A42008D440090471A7D506057
        595C5A595B5A595B5A595B5A595B5A595B5A595B5A595B5A595B59575C554F54
        91C3558DBB558CB9568BB8578AB745709687ADCD5892C4E9E9E9F2F2F2D1D1D1
        3E986D00BA8000D6A000D39C00D39C00D89F00DAA100DAA135EABD0091476152
        575A575759585759585759585759585759585759585759585759575559524C56
        93C4568EBC568DBA588BB73AA8DF23B8F78EB1CF5791C1E9E9E9EBEBEB3F9C71
        00B88100D29F00CE9B00CD9A00CD9A00CF9B00CF9B00CF9A51E6C3008E44604F
        555A555658565658565658565658565658565658565658565658555458504B57
        95C75790BE588FBB5A8CB827B8F55482AE92B4D25590BEE9E9E9EFEFEF008A48
        2CDCB707CDA100C99900C99A00C99900C99900C89800C8976BE7CD008D435E4E
        53585454565554565554565554565554565554565554565554565452564F4958
        96C95891C05990BD5C8DBA27BAF74F7BA497B8D7558EBDE9E9E9FAFAFA139357
        00B38162E0C700C69A00C59900C49800C39800C39800C39786EAD8008E435B4B
        52565253545353545353545353545353545353545353545353545251534D4859
        97CA5992C15A91BE5C8EBC27B9F74A72999DBDD9538CBBE9E9E9FFFFFFFBFBFB
        3EA37200AF7F60DCC600C09793E6D74DE7D14FE9D34CEAD49AF2E6009146594A
        5055505153515153515153515153515153515153515153515153504F524A455B
        99CD5A93C35A92C15C90BF3BA9E121B7F6A0BFD9528ABAE9E9E9FFFFFFFFFFFF
        FCFCFC51AB7F00AB7F5AD9C481E3D600833900893E008D4200914615794C564B
        4E524E4F514F4F514F4F514F4F514F4F514F4F514F4F514F4F514E4D5048435C
        9BCE5B95C45B94C25C94C15C92BF588FBEA5C3DD5089B7E9E9E9FFFFFFFFFFFF
        FFFFFFFCFCFC51AB7F00AA7F79E3D7008B3F5172B157434755474C544A4E514D
        4E4F4E4E4F4E4E4F4E4E4F4E4E4F4E4E4F4E4E4F4E4E4F4E4E4F4D4C4E46415C
        9DD15B96C65B95C45B95C45A94C35691C2A9C6E14F87B6E9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFCFCFC51AC7F00AC85008F434E78B25046454E4A4A4E4B4C4D4C
        4C4D4C4C4D4C4C4D4C4C4D4C4C4D4C4C4D4C4C4D4C4C4D4C4C4D4B4A4B443F5E
        9ED35C97C85C96C65C96C65B95C65693C4ADCAE34D85B3E9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFBFBFB51B0820091464D7AB24E45424C49484C4A4A4C4A
        4A4C4A4A4C4A4A4C4A4A4C4A4A4C4A4A4C4A4A4C4A4A4C4A4A4C49484A423D5F
        9FD45D98C95D97C75D97C75C96C75793C5B2CFE64C84B1E9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E94D7CB24B44414A48474A49494A49
        494A49494A49494A49494A49494A49494A49494A49494A49494A484748413C60
        A1D75E9BCB5E99C95E99C95D98C95895C7B6D2E84A82B0E9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E94B7FB048423E4846454847474847
        47484747484747484747484747484747484747484747484747484545463E3961
        A3D85F9CCC5F9ACA5F9ACA5E99CA5996C8BBD5EB4981ADE9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E94A7FAF463F3B4644434645454645
        45464545464545464545464545464545464545464545464545464343433C3762
        A4DA609CCE609BCC609BCC5F9ACC5997CAC0D9ED477EABE9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAEAEA4980AD453E394542414543424543
        4245434245434245434245434245434245434245434245434244414040393460
        A2DB5E9BD05F9BCE619CCE5F9BCE5A98CCC5DCF0467DAAE9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2F2F24980AC413730423B36423C37423C
        37423C37423C37423C37423C37423C37423C37423C37423C37413A353B322ABC
        DCF77AAED95B9ACD5F9CCE5F9CCE5A9ACDC9DFF2457CA7E9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFB7EA3BF4A82AE4B83B04B83B14B83
        B14B83B14B83B14B83B14B83B14B83B14B83B14B83B14B83B14A82AF447CA980
        A9CBB9D3EAA7C9E56CA4D35B9ACF5999CFCDE2F3437AA6E9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFCFCFCD0E0EEC2DBEE9AC2E25A9AD0CFE3F54177A3E9E9E9FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFEFEFEF3F6F8CBDDEFBDD6EDD3E7F74076A2EEEEEEFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFEFEFEE9EFF5CFE3F63E759FF9F9F9}
      TabOrder = 1
      OnClick = BtnFecharClick
    end
  end
  object MTblPedidoItem: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 616
    Top = 271
    object MTblPedidoItemID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
    end
    object MTblPedidoItemCOD_PEDIDO: TIntegerField
      FieldName = 'COD_PEDIDO'
    end
    object MTblPedidoItemCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
      Required = True
    end
    object MTblPedidoItemDES_DESCRICAO: TStringField
      FieldName = 'DES_DESCRICAO'
      Size = 100
    end
    object MTblPedidoItemVAL_QUANTIDADE: TIntegerField
      FieldName = 'VAL_QUANTIDADE'
      Required = True
    end
    object MTblPedidoItemVAL_PRECOUNITARIO: TFloatField
      FieldName = 'VAL_PRECOUNITARIO'
      DisplayFormat = '##,###,##0.00'
    end
    object MTblPedidoItemVAL_TOTALITEM: TFloatField
      FieldName = 'VAL_TOTALITEM'
      DisplayFormat = '##,###,##0.00'
    end
  end
  object DsPedidoItem: TDataSource
    DataSet = MTblPedidoItem
    Left = 613
    Top = 335
  end
end
