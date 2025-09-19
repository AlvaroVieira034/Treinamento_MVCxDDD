inherited FrmCadCliente: TFrmCadCliente
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Clientes'
  ClientHeight = 656
  ClientWidth = 755
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitTop = -69
  ExplicitWidth = 761
  ExplicitHeight = 685
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlTopo: TPanel
    Width = 755
    inherited BtnInserir: TSpeedButton
      Left = 25
      OnClick = BtnInserirClick
      ExplicitLeft = 25
    end
    inherited BtnAlterar: TSpeedButton
      Left = 141
      OnClick = BtnAlterarClick
      ExplicitLeft = 141
    end
    inherited BtnExcluir: TSpeedButton
      Left = 259
      OnClick = BtnExcluirClick
      ExplicitLeft = 259
    end
    inherited BtnGravar: TSpeedButton
      Left = 376
      OnClick = BtnGravarClick
      ExplicitLeft = 376
    end
    inherited BtnCancelar: TSpeedButton
      Left = 493
      OnClick = BtnCancelarClick
      ExplicitLeft = 493
    end
    inherited BtnSair: TSpeedButton
      Left = 610
      OnClick = BtnSairClick
      ExplicitLeft = 610
    end
  end
  inherited PnlDados: TPanel
    Left = 0
    Top = 65
    Width = 755
    Height = 274
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 65
    ExplicitWidth = 755
    ExplicitHeight = 274
    inherited GrbDados: TGroupBox
      Left = 8
      Top = 5
      Width = 737
      Height = 260
      Caption = ' Dados do Cliente '
      ExplicitLeft = 8
      ExplicitTop = 5
      ExplicitWidth = 737
      ExplicitHeight = 260
      object Label6: TLabel
        Left = 55
        Top = 178
        Width = 43
        Height = 13
        Caption = '*Cidade:'
      end
      object Label7: TLabel
        Left = 482
        Top = 178
        Width = 23
        Height = 13
        Caption = '*UF:'
      end
      object Label8: TLabel
        Left = 61
        Top = 29
        Width = 37
        Height = 13
        Caption = 'C'#243'digo:'
      end
      object Label10: TLabel
        Left = 28
        Top = 78
        Width = 64
        Height = 13
        Caption = 'Raz'#227'o Social:'
      end
      object BtnPesquisarCep: TSpeedButton
        Left = 524
        Top = 98
        Width = 28
        Height = 24
        Hint = 'Pesquisar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FA
          FB5B6E8E425672856F71FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFAFBFC7989A263AECF56B0E227416AFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFE788BA960A8
          CC73DAFE1980D5556F97FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFF4F6F97894B45FAED374D8FE187FD35376A4ECEEF2FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAAB6C94096CA74D7FE1982
          D8517DB1ECEFF3FFFFFFFFFFFFFFFFFFD9D2D39C867F957E6B9B8671937D73AD
          9D9CD8CFCEA59A9D3C75A7197DD25387C1F0F3F7FFFFFFFFFFFFFFFFFFBCAEAE
          A68361F2DE97FEFEB2FEFEC3FEFED7DCD3BC866D688D6D6A9B9AA486AED8EBF1
          F7FFFFFFFFFFFFFFFFFFD5CDCEA57D59FEE996FEEC9EFDF7AEFDFEC4FDFDD6FE
          FEF2F0EDE3846966DAD1D1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8076F0C57A
          FBD687FBE195FDF8B0FDFEC2FDFDD6FDFDE8FEFEFECABEB0C3B6B6FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFA67A5BFED784F8D68CFBE69CFCF6B2FDFEC9FDFDCEFD
          FDDBFDFDE1FCFBDBA3918EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBB855AFBD283
          F8DC8FF9E39EFBEDA8FDFBC2FDFDCCFDFDC8FDFDCEFEFED2A6928CFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFB18362FDCC79FBEB9FFDFED0FCF8D8FCEEABFDFBBEFD
          FDB6FDFEBCFCFBB9B09F97FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB5998BF2B66A
          FCE395FDFDBEFDFED1FBE9A6FCF1A8FBEB9EFEFBABE1D39ACEC4C2FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFDCD4D3CB9264FDC875FBE698FBEEA3FBE69AF6D689FC
          DE8FFBE396BFA792F3F0F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFDCFC2BF
          D29A6BF2B86CF9CC7BF9D182FBD07DF1CA83CAAE92E3DCDCFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEE3DCDBCBB0A0D2A57DD8AA7DCEAE90D1
          C1B8F0EDEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = BtnPesquisarCepClick
      end
      object Label3: TLabel
        Left = 405
        Top = 102
        Width = 23
        Height = 13
        Caption = 'Cep:'
      end
      object Label1: TLabel
        Left = 39
        Top = 128
        Width = 59
        Height = 13
        Caption = 'Logradouro:'
      end
      object Label2: TLabel
        Left = 29
        Top = 153
        Width = 69
        Height = 13
        Caption = 'Complemento:'
      end
      object Label4: TLabel
        Left = 52
        Top = 204
        Width = 46
        Height = 13
        Caption = 'Telefone:'
      end
      object Label5: TLabel
        Left = 344
        Top = 204
        Width = 35
        Height = 13
        Caption = '*CNPJ:'
      end
      object Label9: TLabel
        Left = 10
        Top = 53
        Width = 88
        Height = 13
        Caption = '*Nome do Cliente:'
      end
      object Label11: TLabel
        Left = 55
        Top = 103
        Width = 43
        Height = 13
        Caption = 'Contato:'
      end
      object Label13: TLabel
        Left = 385
        Top = 128
        Width = 41
        Height = 13
        Caption = 'N'#250'mero:'
      end
      object Label14: TLabel
        Left = 66
        Top = 230
        Width = 32
        Height = 13
        Caption = 'E-mail:'
      end
      object EdtCep: TEdit
        Left = 432
        Top = 99
        Width = 89
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 9
        TabOrder = 5
        OnExit = EdtCepExit
      end
      object EdtCidade: TEdit
        Left = 106
        Top = 174
        Width = 277
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 100
        TabOrder = 9
      end
      object EdtUF: TEdit
        Left = 511
        Top = 174
        Width = 41
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 2
        TabOrder = 10
      end
      object EdtCodigoCliente: TEdit
        Left = 106
        Top = 25
        Width = 70
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        Enabled = False
        MaxLength = 9
        TabOrder = 0
      end
      object EdtRazaoSocial: TEdit
        Left = 106
        Top = 74
        Width = 447
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 100
        TabOrder = 3
      end
      object EdtLogradouro: TEdit
        Left = 106
        Top = 124
        Width = 269
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 100
        TabOrder = 6
      end
      object EdtComplemento: TEdit
        Left = 106
        Top = 149
        Width = 447
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 8
      end
      object EdtTelefone: TEdit
        Left = 106
        Top = 200
        Width = 161
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 20
        TabOrder = 11
      end
      object EdtCnpj: TEdit
        Left = 391
        Top = 200
        Width = 161
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 18
        TabOrder = 12
        OnExit = EdtCnpjExit
        OnKeyPress = EdtCnpjKeyPress
      end
      object EdtNomeFantasia: TEdit
        Left = 106
        Top = 49
        Width = 447
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 2
      end
      object EdtContato: TEdit
        Left = 106
        Top = 99
        Width = 269
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 4
      end
      object EdtNumero: TEdit
        Left = 432
        Top = 124
        Width = 120
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 15
        TabOrder = 7
      end
      object EdtEmail: TEdit
        Left = 106
        Top = 226
        Width = 447
        Height = 21
        CharCase = ecLowerCase
        MaxLength = 100
        TabOrder = 13
      end
      object RdgSituacao: TRadioGroup
        Left = 367
        Top = 8
        Width = 184
        Height = 36
        Caption = ' Situa'#231#227'o '
        Columns = 2
        ItemIndex = 1
        Items.Strings = (
          'Inativo'
          'Ativo')
        TabOrder = 1
      end
    end
  end
  inherited PnlGrid: TPanel
    Left = 0
    Top = 339
    Width = 755
    Height = 270
    Align = alClient
    ExplicitLeft = 25
    ExplicitTop = 362
    ExplicitWidth = 755
    ExplicitHeight = 229
    inherited LblTotRegistros: TLabel
      Left = 655
      Top = 250
      Height = 17
      Anchors = [akRight, akBottom]
      ExplicitLeft = 655
      ExplicitTop = 250
      ExplicitHeight = 17
    end
    inherited GrbGrid: TGroupBox
      Left = 8
      Top = 5
      Width = 737
      Height = 242
      Anchors = [akRight, akBottom]
      Caption = ' Clientes Cadastrados '
      ExplicitLeft = 8
      ExplicitTop = 5
      ExplicitWidth = 737
      ExplicitHeight = 242
      object DbGridClientes: TDBGrid
        Left = 12
        Top = 20
        Width = 717
        Height = 211
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = DbGridClientesCellClick
        OnDblClick = DbGridClientesDblClick
        OnKeyDown = DbGridClientesKeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'cod_cliente'
            Title.Alignment = taCenter
            Title.Caption = 'C'#243'digo'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'des_nomefantasia'
            Title.Caption = 'Nome Fantasia'
            Width = 229
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'des_razaosocial'
            Title.Caption = 'Raz'#227'o Social'
            Width = 218
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'des_cidade'
            Title.Caption = 'Cidade'
            Width = 223
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'des_uf'
            Title.Alignment = taCenter
            Title.Caption = 'UF'
            Width = 40
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'des_telefone'
            Title.Caption = 'Telefone'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'des_cep'
            Title.Alignment = taCenter
            Title.Caption = 'CEP'
            Width = 68
            Visible = True
          end>
      end
    end
  end
  object PnlPesquisar: TPanel
    Left = 0
    Top = 609
    Width = 755
    Height = 47
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 3
    ExplicitLeft = 8
    ExplicitTop = 601
    DesignSize = (
      755
      47)
    object BtnPesquisar: TSpeedButton
      Left = 648
      Top = 10
      Width = 96
      Height = 27
      Anchors = [akRight, akBottom]
      Caption = '&Pesquisar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFCCCCCCCCCCCCF5F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFCCCCCC497FAA4980ACB1BDC6CFCFCFCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC407F
        AF1EAAFF5AC8FF4593C7BB8825B67E0EB57B09B67E0DB88113BB8211B6831B90
        7E5B7A7A7C7B79787B79788F816B72A1C558C8FFBAF2FF4193CCB67E0EFFFFFF
        FFFFFFFFFFFFB47800F0EEF481848DB6B9BEE4E8ECE2E5EAE4E6EAB8B7B7827A
        76CFE3ED3290D4FFFFFFB47B09FFFFFFFFFFFFFFFFFFC99A3B928267B9BBBFE8
        DDCEEEC57DF6D789FCE49AECE7D8BBBABC9B9084FFFFFFFFFFFFB47A07FFFFFF
        FFFFFFFFFFFFFFFFFF7B7A7CF0F3F8E7B572F0CF92F6DC94FFEFA4FBE499F0F2
        F8818288FFFFFFFFFFFFB47A08FFFFFFFFFFFFFFFFFFE1CAB07F7F81F5F9FEEB
        C696F5E1BEF3DAA0F6DB94F4D587F5F9FF868587FFFFFFFFFFFFB47B08FFFFFF
        D5BB9DDAC3A8B65A0084888CFEFFFFE3B076FAF2E4F4E1BDEFCE91ECC37CFEFF
        FF8A898BFFFFFFFFFFFFB47B08FFFFFFFFFFF7FFFFFFB65E06A9A39BCED2D5F6
        E3CFE2B074E9C494E5B571F8EBD7CFD1D79C8A67FFFFFFFFFFFFB47B09FFFFFF
        D6B892DBC1A1B5600ACBA2748F9093D3D7DCFFFFFFFFFFFFFFFFFFD1D3D79293
        9CB7821AFFFFFFFFFFFFB47B08FFFFFFFFFBE4FFFFF2B5600BE2B580D7AC7A9F
        8A7491959B9194988F9195B5B1ABFFFFFFB87E09FFFFFFFFFFFFB57B08FFFFFF
        DDB382E1BB8EB95D04BD6108BE6106BD6106C06003C06001BB5B00E2BA8BFFFF
        FFB67C09FFFFFFFFFFFFB57C09FFFFFF44C4FF46C8FFE5BB8649CEFF4ACFFFE7
        BD894ACFFF4ACEFFE5BA8542C7FFFFFFFFB67C09FFFFFFFFFFFFB67E0EFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFB67E0EFFFFFFFFFFFFBD8C27B67E0EB67C09B67B08B57B08B67B08B67B08B5
        7B08B67B08B67B08B57B08B67C09B67E0EBD8C27FFFFFFFFFFFF}
      OnClick = BtnPesquisarClick
    end
    object Label12: TLabel
      Left = 12
      Top = 19
      Width = 43
      Height = 11
      Caption = 'Filtrar por:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object EdtPesquisar: TEdit
      Left = 156
      Top = 14
      Width = 488
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      OnKeyPress = EdtPesquisarKeyPress
    end
    object CbxFiltro: TComboBox
      Left = 61
      Top = 14
      Width = 94
      Height = 21
      TabOrder = 0
      Text = 'Todos'
      OnChange = CbxFiltroChange
    end
  end
end
