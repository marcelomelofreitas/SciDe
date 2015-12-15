object MainForm: TMainForm
  Left = 452
  Top = 138
  Width = 1057
  Height = 775
  Caption = 'SciDe - test form'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlContainer: TPanel
    Left = 0
    Top = 29
    Width = 1049
    Height = 681
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlContainer'
    TabOrder = 0
    object spl1: TSplitter
      Left = 0
      Top = 492
      Width = 1049
      Height = 5
      Cursor = crVSplit
      Align = alBottom
    end
    object txtLog: TMemo
      Left = 0
      Top = 497
      Width = 1049
      Height = 184
      Align = alBottom
      Color = 16771799
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object Sciter1: TSciter
      Left = 0
      Top = 0
      Width = 1049
      Height = 492
      Align = alClient
      BevelKind = bkTile
      BevelWidth = 2
      EventMap = <
        item
          Selector = '#cmdEventHandler, .cmd-event-handler'
          OnControlEvent = Sciter1EventHandlers0ControlEvent
        end>
      PopupMenu = ctxSciter
      TabOrder = 1
      OnDocumentComplete = Sciter1DocumentComplete
      OnLoadData = Sciter1LoadData
      OnMessage = Sciter1Message
      OnScriptingCall = Sciter1ScriptingCall
    end
  end
  object sbr: TStatusBar
    Left = 0
    Top = 710
    Width = 1049
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object cbr: TCoolBar
    Left = 0
    Top = 0
    Width = 1049
    Height = 29
    AutoSize = True
    Bands = <
      item
        Control = tbr
        ImageIndex = -1
        Width = 1045
      end>
    object tbr: TToolBar
      Left = 9
      Top = 0
      Width = 1032
      Height = 25
      ButtonWidth = 88
      Caption = 'tbr'
      EdgeBorders = []
      Flat = True
      Images = iml
      List = True
      ShowCaptions = True
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = acFileOpen
        AutoSize = True
      end
      object ToolButton2: TToolButton
        Left = 66
        Top = 0
        Action = acFileSave
        AutoSize = True
      end
      object ToolButton3: TToolButton
        Left = 131
        Top = 0
        Action = acRefresh
        AutoSize = True
      end
      object ToolButton4: TToolButton
        Left = 199
        Top = 0
        Action = acClearLog
        AutoSize = True
      end
      object ToolButton5: TToolButton
        Left = 271
        Top = 0
        Action = acDumpHTML
        AutoSize = True
      end
    end
  end
  object mm1: TMainMenu
    Images = iml
    Left = 209
    Top = 104
    object Actions1: TMenuItem
      Caption = '&File'
      object mnuOpenFile: TMenuItem
        Action = acFileOpen
      end
      object mnuSaveFile: TMenuItem
        Action = acFileSave
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object NavigatetoSciterwebsite1: TMenuItem
        Caption = 'Navigate to Sciter website'
        OnClick = NavigatetoSciterwebsite1Click
      end
      object DumpHTML1: TMenuItem
        Action = acDumpHTML
      end
    end
    object ests1: TMenuItem
      Caption = 'Tests'
      object mnuCallNativeMethod: TMenuItem
        Caption = 'Call native method "Echo"'
        OnClick = cmdCallNativeClick
      end
      object mnuTestJsonSerializer: TMenuItem
        Caption = 'Test JSON serializer'
        OnClick = mnuTestJsonSerializerClick
      end
    end
  end
  object ctxSciter: TPopupMenu
    Left = 207
    Top = 136
    object mnuElementAtCursor: TMenuItem
      Caption = 'Find element at cursor'
      OnClick = mnuElementAtCursorClick
    end
  end
  object sfd: TSaveDialog
    DefaultExt = 'htm'
    Filter = 'HTML files (*.htm)|*.htm'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 200
    Top = 270
  end
  object ofd: TOpenDialog
    Filter = 'HTML files|*.htm*'
    Left = 233
    Top = 270
  end
  object iml: TImageList
    Left = 273
    Top = 269
    Bitmap = {
      494C010105000A00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001001000000000000018
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000945230463046304630463046
      3046304630463046304630469452000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7FFF7FFF7FFF7FFF7F
      FF7FFF7FFF7FFF7FFF7FFF7F3046000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7F9C739C739C739C73
      9C739C739C739C739C73FF7F3046000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7F9C739C739C739C73
      9C739C739C739C739C73FF7F3046000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7F9C739C7376463011
      300D301155429C739C73FF7F3046000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7F9C73764693197936
      793A7936931976429C73FF7F3046000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7F9C7330157936F32D
      14366026793630159C73FF7F3046000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7F9C733011793A1A5B
      FA526026793A30119C73FF7F3046000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7F9C73301579366026
      7C637642793630159C73FF7F3046000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7F9C73974693197936
      793A79369319554239679C733046000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7FBD779D7376465015
      301130157646F75E18635A6B3046000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7FBD77BD77BD779C77
      9C739C73B556734E524A30463046000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7FBD77BD77BD77BD77
      BD77BC77734EBD779C739C733046000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7FBD77BD77BD77BD77
      BD771863D5569C73FF7F30467B6F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000003046FF7FFF7FFF7FFF7FFF7F
      FF7FFF7FDE7BFF7F30467B6F0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000186330463046304630463046
      30463046304630467B6F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003967396739673967396739673967
      3967396739673967396739673967000000000000BA5298315529542933293325
      3225112111211021EF1CEF1CEE1CCD180000000055426E256E256E256E256E25
      6E256E256E256E256E256E256E2500000000000000005A7F2F7E387F00000000
      000000000000000000000000000000000000696A686A486A4766476647664766
      4766476647664766476647666966000000000000B9353E461C421511C810D856
      F85A195F39632A25F318F318F318EE1C000000005542BF733B633B633B633B63
      3B633B633B633B633B633B636E250000000000000000507EA170066D9B7F0000
      00000000000000000000ED79597F00000000686A476AF57FD37FD27FD27FD27F
      D27FD27FD27FD27FD27FF47FEC72366F00000000BA397F4E1D421C426E25E818
      F1359D6F9E73F1391419141DF318EF1C000000005542BF739E6F9E6F7E6B402E
      7E675E675E635E633E5F3B636E250000000000000000177FC2788168AA71DE7F
      000000000000000000008160597B00000000686A896E717BB47F907F907F907F
      907F907F907F907F907FB27F717B8D6600000000DA397F525E4A1D426E250000
      E8187D677D6BD03135213521141DEF1C000000005542BF73BF739E6F402E202E
      715B715B5D635E635E633B636E250000000000000000FF7FEC7D047DA268D576
      0000000000000000057189719C7B00000000486AED76ED72D77F6E7F6E7F6F7F
      6F7F6F7F6F7F6F7F6F7F907FD57F696A00000000FA3DBF567F525E4A6E256E25
      6E256E258E29AF2D5729362535211021000000007546BF77BF73402E402E402E
      402E402E402E765F5E633B636E2500000000000000000000BD7F687D0479056D
      1877000000000E7E8168597B000000000000486A517B886EFB7FFB7FFB7FFB7F
      6E7F6E7F6E7F6E7F6E7F6E7FB47FEF72366F00001B42DF5ABF569F523E461D42
      1C42FB3DDA39BA35782D572956251121000000007646DF77DF77BF73402E402E
      BA6F9E6BBA6B402E5E673B636E250000000000000000000000009C7F477DE37C
      8975597FAA7DA174B37E0000000000000000476AD57F686A2666266626662666
      EB766D7F4D7F4D7F4C7F4C7F707F957B8D6600003B46FF5EDF5A993178297725
      571D36191515140DF408782D57291121000000007646DF7BDF776E5BBF73402E
      9F6F402E9E6B4E577E673B636E2500000000000000000000000000009C7F677D
      C27CC278C178467D000000000000000000004766D77F6E7F2D7B2D7B2D7B2D7B
      686AEA76FB7FDA7FDA7FDA7FDA7FFB7F476A00005C4AFF5E993100000000FF7B
      BE779E6F7D6B5C633C5FF408782D322500000000974AFF7BDF7B402EB56BBF77
      DA73402E402E9E6F7E6B3B636E2500000000000000000000000000000000387F
      477D257D267D0000000000000000000000004766D87F6E7F6E7F6E7F6E7F6E7F
      6E7F686A26662666266626664766476A6A6A00005C4EFF5EBA35000000000000
      FF7BBE779E6F7D6B5C63140D9931332500000000974AFF7FFF7BDA73402E402E
      402E402E4032402E9E6F3B636E2500000000000000000000000000007B7F677D
      887D467D477DCB7D000000000000000000004766D97F4D7F4D7F4D7F4D7F4D7F
      4D7F4D7F0B7B0B7B2B7B967F476A3573000000007D4EFF5EDB39000000000000
      0000FF7BBE779E6F7D6B1515DA39332900000000B74EFF7FFF7FFF7BDA73B56B
      9163402E402EBF739E6F3B636E25000000000000000000000000927E257D467D
      EC7D7A7F2E7E677D2E7E00000000000000004766DA7F4C7F4C7FB67FDB7FFB7F
      FB7FFB7FFB7FFB7FFB7FFC7F476ABB7B000000009D52FF5E1C42000000000000
      00000000FF7BBE779E6F3619FB3D542900000000B84EFF7FFF7FFF7FFF7BDF7B
      DF7B402EBF77BF733B633B636E250000000000000000597FAA7D467D677DCB7D
      000000000000EC7D467D4F7E000000000000476AFB7FDB7FDB7FFB7F26664766
      47664766476647664766476A8B6A000000000000BE56FF5E3D46000000000000
      000000000000FF7BBE77571DCC18552900000000D85200000000FF7FFF7FFF7F
      FF7BDF7BDF77F2356E256E256E25000000000000D47EAA7D887D897D717E0000
      0000000000000000387F887D0D7E00000000CF6E476A47664766476A8C6A0000
      0000000000000000000000000000000000000000DE5AFF5E5F4A000000000000
      0000000000000000FF7B7725762D762D00000000D952000000000000FF7FFF7F
      FF7FFF7BDF7BF2357E67FA566E25000000000000B37E897D887DF67E00000000
      000000000000000000009B7FB37E000000000000000000000000000000000000
      0000000000000000000000000000000000000000DE5ADE5ADE5ABE569D569D52
      7C4E5C4A3C461B461B42FA3DDA39BA3900000000D9560000000000000000FF7F
      FF7FFF7FFF7BF235FA5655421B5F0000000000007A7FAA7D387F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000D956D952D852D852B84EB74E
      974A974A7646764676461B5F0000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080030000000000008003000000000000
      8003000000000000800300000000000080030000000000008003000000000000
      8003000000000000800300000000000080030000000000008003000000000000
      8003000000000000800300000000000080030000000000008003000000000000
      8007000000000000800F000000000000FFFFFFFFFFFFFFFF000380018003C7FF
      000380018003C3F3000180018003C1F3000180018003C1E3000180018003E0C7
      000080018003F00F000080018003F81F00008C018003FC3F00008E018003F81F
      00018F018003F00F00018F818003C1C700038FC1B00383E303FF8FE1B80387F3
      FFFF8001BC038FFFFFFFFFFF8007FFFF00000000000000000000000000000000
      000000000000}
  end
  object al: TActionList
    Images = iml
    Left = 303
    Top = 269
    object acFileOpen: TAction
      Caption = 'Open...'
      ImageIndex = 0
      ShortCut = 16463
      OnExecute = mnuOpenFileClick
    end
    object acFileSave: TAction
      Caption = 'Save...'
      ImageIndex = 1
      OnExecute = cmdSaveToFileClick
    end
    object acRefresh: TAction
      Caption = 'Refresh'
      ImageIndex = 2
      ShortCut = 116
      OnExecute = cmdReloadClick
    end
    object acClearLog: TAction
      Caption = 'Clear log'
      ImageIndex = 3
      OnExecute = acClearLogExecute
    end
    object acDumpHTML: TAction
      Caption = 'Dump HTML'
      ImageIndex = 4
      OnExecute = acDumpHTMLExecute
    end
  end
end
