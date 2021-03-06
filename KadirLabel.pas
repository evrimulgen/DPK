unit KadirLabel;

interface

uses
  SysUtils, Classes, Controls, StdCtrls,Graphics,Dialogs,Messages,windows,cxButtonEdit,
  forms,adodb,ImgList,Para,strUtils,ExtCtrls, Math,db,buttons, Types, kadirType,cxButtons,
  ListeAcForm,registry,dxNavBarBase, dxNavBar,dxNavBarCollns,ActnList,Menus,ActnMan,
  cxTextEdit,cxCalendar,cxGrid,ComCtrls,KadirMenus,cxGridDBTableView,cxGridDBBandedTableView,
  cxGridCustomView,cxCustomData,cxImageComboBox,FScxGrid,cxFilter,cxGridExportLink,
  cxCheckBox,cxEdit,cxGroupBox,dxLayoutContainer,cxGridStrs, cxFilterConsts,
  cxFilterControlStrs,cxGridPopupMenuConsts,cxClasses;


type
  TRenk = (Yellow, Red);
  TRenkChangeEvent = PROCEDURE(Sender: TObject; Renk: TRenk) OF OBJECT;


  TGoster = (fgEvet,fgHayir);
  TDonusum = (dsRakamToYazi,dsDoktorKodToAdi,dsBransKoduToadi,dsHizmetKoduToAdi,dsTckimlikToHasta,dsTanimToadi);
  TPanelSonuc = (psYan,psDik);
  TTarihValueTip = (tvDate,tvString);
  TShowTip = (stShow,stModal);

  THb = class(TPersistent)
  private
   FDosyaNo,FTc : string;
   protected
   public
  published
    property DosyaNo : string read FDosyaNo write FDosyaNo;
    property Tc : string read FTc write FTc;
  end;

  TButtonlar = class(TPersistent)
   private
     FSecButton : string;
     FEditButton: string;
   protected
   public

   published
    property SecButton : string read FSecButton write FSecButton;
    property EditButton : string read FEditButton write FEditButton;
  end;



type
   THastaAdiFont = TFont;
   THastaAdiFontChangeEvent = PROCEDURE(Sender: TObject; HastaAdiFont: THastaAdiFont) OF OBJECT;

  THastaBilgileriGroup = class(TGroupBox)
     HastaAdi : TEdit;
     HastaSoyadi : TEdit;
   private
     FHastaAdi : TEdit;
     FTcKimlik : string;
     FDosyaNo : string;
     FHb : THb;
     FHHastaAdiFont : THastaAdiFont;
     FHastaAdiFont : THastaAdiFont;
     FHastaSoyaAdi : THastaAdiFont;
     FOnHastaAdiFontChange : THastaAdiFontChangeEvent;
//     procedure WMFontChange(var Message: TMessage); message WM_FONTCHANGE;

     procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;

   procedure SetHastaAdiFont (const value : Tfont);
   function GetHastaAdiFont : Tfont;
   procedure SetHastaSoyadiFont (const value : Tfont);
   function GetHastaSoyadiFont : Tfont;
   procedure SetHb(const Value: THb);

   protected
   public
     CONSTRUCTOR Create(AOwner: TComponent); override;
  //   destructor Destroy; override;
   published
    property TcKimlik : string read FTcKimlik write FTcKimlik;
    property DosyaNo : string read FDosyaNo write FDosyaNo;
    property Hb : THb read FHb write setHb;
  //  property GHastaAd : TEdit read FHastaAd write setHastaAdi;
    property HHastaAdiFont : THastaAdiFont read GetHastaAdiFont write SetHastaAdiFont;
    property HHastaSoyadiFont : THastaAdiFont read GetHastaSoyadiFont write SetHastaSoyadiFont;

    property OnHastaAdiFontChange: THastaAdiFontChangeEvent read FOnHAstaAdiFontChange write FOnHastaAdiFontChange;
//    property HastaSoyad : TEdit read HastaSoyadi write HastaSoyadi;
  end;

  TdxNavBarKadirItem = class(TdxNavBarItem)
  private
    F_ShowTip_ : integer;
    F_FormId : integer;
   protected
   public
   published
    property _ShowTip_: integer read F_ShowTip_ write F_ShowTip_;
    property _FormId: integer read F_FormId write F_FormId;
  end;




  TMainMenuKadir = class(TdxNavBar)
   private
     FTimerShow : TTimer;
     FTimerGizle : TTimer;
   //  FActionManager : TActionManager;
     FConn : TADOConnection;
     FKullaniciAdi : string;
     FTagC : integer;
     FSlite : integer;
     FOnHastaAdiFontChange : THastaAdiFontChangeEvent;
   protected

   public
      MenuId : integer;
     CONSTRUCTOR Create(AOwner: TComponent); override;
  //   destructor Destroy; override;
     procedure MenuGetir;
     function MenuClick(_tag_ : integer) : integer;
     procedure LinkClick(Sender: TObject; ALink: TdxNavBarItemLink);
     procedure TimerShowTimer(Sender: TObject);
     procedure TimerGizleTimer(Sender: TObject);
     procedure Gizle;
     procedure Goster;
     function GetTagC : integer;
     procedure setTagC(const value : integer);
     procedure ActionListExecute(Sender: TObject);
     function TusKontrol(Tus : string) : integer;
   published
    property TimerShow: TTimer read FTimerShow write FTimerShow;
    property TimerGizle: TTimer read FTimerGizle write FTimerGizle;
 //   property ActionList : TActionManager read FActionManager write FActionManager;
    property KullaniciAdi : string read FKullaniciAdi write FKullaniciAdi;
    property TagC : integer read GetTagC write setTagC;
    property Slite : integer read FSlite write FSlite;
    property Conn : TADOConnection read FConn write FConn;
 //   property OnHastaAdiFontChange: THastaAdiFontChangeEvent read FOnHAstaAdiFontChange write FOnHastaAdiFontChange;
//    property HastaSoyad : TEdit read HastaSoyadi write HastaSoyadi;
  end;





  TKadirHastaBilgiPanel = class(TPanel)
    private
      FGiris : string;
      FSonuc : TPanelSonuc;
      FConn : TADOConnection;
      FOnRenkChange: TRenkChangeEvent;
      FOnDonustur : TNotifyEvent;
      FOnGuncelle : TNotifyEvent;
    protected
  //    function CihazTestKodu_To_LisTestKodu(code : string) : string;
    public
//      CONSTRUCTOR Create(AOwner: TComponent); override;
//      destructor Destroy; override;
      function Donustur : string;


     published
       property Conn : TADOConnection read FConn write FConn;
       property OnDonustur : TNotifyEvent read FOnDonustur write FOnDonustur;
       PROPERTY OnRenkChange: TRenkChangeEvent read FOnRenkChange write FOnRenkChange;
       property Giris : string read FGiris write FGiris;
       property Donusum : TPanelSonuc read FSonuc write FSonuc;
  end;

  TNotifyEventDonustur = procedure(Sender: TObject ; Giris : string) of object;

  TKadirLabel = class(TLabel)
    private
      FGiris : string;
      FDonusum : TDonusum;
      FConn : TADOConnection;
      FOnRenkChange: TRenkChangeEvent;
      FOnDonustur : TNotifyEventDonustur;
      FOnGuncelle : TNotifyEvent;
    protected
  //    function CihazTestKodu_To_LisTestKodu(code : string) : string;
    public
      CONSTRUCTOR Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function Donustur : string;
      function GetGiris : string;
      procedure setGiris(const value : string);

     published
       property Donusum : TDonusum read FDonusum write FDonusum;
       property Conn : TADOConnection read FConn write FConn;
       property OnDonustur : TNotifyEventDonustur read FOnDonustur write FOnDonustur;
       PROPERTY OnRenkChange: TRenkChangeEvent read FOnRenkChange write FOnRenkChange;
       property Giris : string read getGiris write setGiris;
  end;


    TListeAc = class(TComponent)
      btnSecButton: TSpeedButton;
    private
      FListeBaslik : string;
      FColCount : integer;
      FCols : string;
      FColsW : string;
      FColbaslik : string;
      FTable : string;
      FWhere : string;
      FConn : TADOConnection;
      FSQL : TADOQuery;
      Fstrings : ArrayListeSecimler;
      FstringsW : TstringList;
      FFiltercol : integer;
      FFilter : string;
      FBaslikRenk : tcolor;
      FDipRenk : Tcolor;
      FImajList : TImageList;
      FButtonImajIndex : TImageIndex;
      FVersiyon : string;
      FRenkler : TButtonlar;
      FLin : TStrings;
      Flin1 : TStrings;
      FCalistir : TGoster;
      FKapatTus : word;
      FBiriktirmeliSecim : Boolean;
      FSiralamaKolonu : string;
      FSkinName : string;
      FGrup : Boolean;
      FGrupCol : integer;

      procedure SetImageIndex(Value: TImageIndex);
      function GetVersiyon : string;
      procedure setLines(const value : TStrings);
      function getlines : TStrings;
      procedure setLines1(const value : TStrings);
      function getlines1 : TStrings;

      procedure setBiriktir(const value : Boolean);
      function getBiriktir : Boolean;

    protected
      procedure QuerySelect (Q: TADOQuery; sql:string);
      procedure Split (const Delimiter: Char; Input: string; const Strings: TStrings) ;

    public
      constructor Create(AOwner: TComponent) ; override;
      destructor Destroy; override;
      function ListeGetir : ArrayListeSecimler;

  published
      property ListeBaslik : string read FListeBaslik write FListeBaslik;
      property TColcount : integer read Fcolcount write Fcolcount;
    //  property TCols : string read Fcols write Fcols;
      property TColsW : string read FcolsW write FcolsW;
      property Table : string read Ftable write Ftable;
      property Where : string read FWhere write FWhere;
    //  property Colbaslik : string read FColbaslik write FColbaslik;
      property Conn : TADOConnection read FConn write FConn;
      property Filtercol : integer read Ffiltercol write Ffiltercol;
      property Filter : string read Ffilter write Ffilter;
      property BaslikRenk : Tcolor read FBaslikRenk write FBaslikRenk;
      property DipRenk : Tcolor read FDipRenk write FDipRenk;
      property ImajList : TImageList read FImajList write FImajList;
      property ButtonImajIndex : TImageIndex read FButtonImajIndex write SetImageIndex default 0;
      property Versiyon : string read GetVersiyon;
      property Renkler : TButtonlar read FRenkler write FRenkler;
      property Kolonlar : TStrings read FLin write setLines;
      property KolonBasliklari : TStrings read FLin1 write setLines1;
      property Calistir : TGoster read FCalistir write FCalistir;
      property KapatTus : word read FKapatTus;
      property BiriktirmeliSecim : Boolean read getBiriktir write setBiriktir;
      property SiralamaKolonu : string read FSiralamaKolonu write FSiralamaKolonu;
      property SkinName : string read FSkinName write FSkinName;
      property Grup : Boolean read FGrup write FGrup;
      property GrupCol : integer read FGrupCol write FGrupCol default -1;
  end;


type
  TcxButtonEditKadir = class(TcxButtonEdit)
   private
     FListeAc : TListeAc;
     FindexField : Boolean;
     Ftanim : string;
     FwhereColum : string;
     FListeAcTus : TShortCut;
     FBosOlamaz : Boolean;
     FtanimDeger : string;
     procedure DoEditKeyDown(var Key: Word; Shift: TShiftState);
   protected
   public
       constructor Create(AOwner: TComponent) ; override;
   published
     property ListeAc: TListeAc read FListeAc write FListeAc;
     property indexField : Boolean read FindexField write FindexField;
     property tanim : string read Ftanim write Ftanim;
     property whereColum : string read FwhereColum write FwhereColum;
     property ListeAcTus : TShortCut read FListeAcTus write FListeAcTus;
     property BosOlamaz : Boolean read FBosOlamaz write FBosOlamaz Default false;
     property tanimDeger : string read FtanimDeger write FtanimDeger;
end;

Values = Array of Variant;
type
  TcxGridKadir = class(TcxGrid)
    private
      FPMenu : TPopupMenu;
      FExcelFileName : string;
      FExceleGonder : Boolean;
      FDataset : TADOQuery;
      FDataSource : TDataSource;
      procedure TClick(sender : TObject);
      procedure cxGridToTr;
      procedure DatasetAfterOpen(DataSet: TDataSet);

   protected
   public
      constructor Create(AOwner: TComponent) ; override;
    //  destructor Destroy; override;
      function SelectedCellValue(ColonFieldName : string ; Row : integer) : Variant; overload;
      function SelectedCellValue(ColonFieldName : string) : Values; overload;
      procedure SelectedCellSetValue(ColonName : string ; Row : integer ; Value : Variant);
   published
     property ExcelFileName : string read FExcelFileName write FExcelFileName;
     property ExceleGonder : Boolean read FExceleGonder write FExceleGonder;
     property Dataset : TADOQuery read FDataset write FDataset;
     property DataSource : TDataSource read FDataSource write FDataSource;
  end;




type
  TMenuItemModul = class(TMenuItem)
    private
      FModul : string;
      FIslem : string;
      FFormId : integer;
   protected
   public
   published
     property Modul : string read FModul write FModul;
     property Islem : string read FIslem write FIslem;
     property FormId : integer read FFormId write FFormId;
  end;



type
  TToolButtonKadir = class(TToolButton)
    private
      FModul : string;
      FIslem : string;
   protected
   public
   published
     property Modul : string read FModul write FModul;
     property Islem : string read FIslem write FIslem;
  end;

type
  TcxButtonKadir = class(TcxButton)
   private
     FButtonName : string;
     FNewButtonVisible : Boolean;
   protected
   public
   published
     property ButtonName : string read FButtonName write FButtonName;
     property NewButtonVisible : Boolean read FNewButtonVisible write FNewButtonVisible;
end;

type
  TcxTextEditKadir = class(TcxTextEdit)
   private
     FBosOlamaz : Boolean;
   protected

   public
     constructor Create(AOwner: TComponent) ; override;
     function GetSQLValue : string;
   published
     property BosOlamaz : Boolean read FBosOlamaz write FBosOlamaz Default False;
end;


type
  TcxCustomDateEditPropertiesKadir = class(TcxDateEditProperties)
   private
   protected
   public
      procedure ValidateDisplayValue(var ADisplayValue: TcxEditValue;
      var AErrorText: TCaption; var AError: Boolean;
      AEdit: TcxCustomEdit);override;
  published
end;

type
  TcxDateEditKadir = class(TcxDateEdit)
   private
     FBosOlamaz : Boolean;
     FValueTip : TTarihValueTip;
   protected
   public
     constructor Create(AOwner: TComponent) ; override;
     function GetValue(format : string = 'YYYYMMDD') : string;
     function GetSQLValue(format : string = 'YYYYMMDD') : string;
     class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
   published
     property BosOlamaz : Boolean read FBosOlamaz write FBosOlamaz;
     property ValueTip : TTarihValueTip read FValueTip write FValueTip default tvDate;
end;




type
  TcxCheckBoxKadir = class(TcxCheckBox)
   private
     FBosOlamaz : Boolean;
     FSecili : string;
     FSeciliDegil : string;
   protected
   public
     constructor Create(AOwner: TComponent) ; override;
     function GetSQLValue : string;
   published
     property BosOlamaz : Boolean read FBosOlamaz write FBosOlamaz;
     property Secili : string read FSecili write FSecili;
     property SeciliDegil : string read FSeciliDegil write FSeciliDegil;
end;


type

  TBClick = PROCEDURE(Sender: TObject ; ButtonTag : integer) OF OBJECT;
  Buttons = class(TcxButtonKadir);

  TcxTopPanelKadir = class(TcxGroupBox)
   private
     Btn1 : TcxButtonKadir;
     Btn2 : TcxButtonKadir;
     FButon1Goster : Boolean;
     FButon2Goster : Boolean;
     FButon1Caption : string;
     FButon2Caption : string;
     ilkTarih : TcxDateEditKadir;
     sonTarih : TcxDateEditKadir;
     FKurumTip : Boolean;
     FOnButonClick : TBClick;
     FButtonTag : integer;
   protected
   public
     constructor Create(AOwner: TComponent) ; override;
    // destructor Destroy; override;
     function GetValue(var tarih2 : string) : string;
   //  function TarihCreate : Boolean;
     function getButon1Goster : Boolean;
     procedure setButon1Goster(const value : Boolean);
     function getButon2Goster : Boolean;
     procedure setButon2Goster(const value : Boolean);
     procedure ButonClick(Sender: TObject);
   published
     property Buton1Caption : string read FButon1Caption write FButon1Caption;
     property Buton2Caption : string read FButon2Caption write FButon2Caption;
     property Buton1Goster : Boolean read getButon1Goster write setButon1Goster;
     property Buton2Goster : Boolean read getButon2Goster write setButon2Goster;
  //   property ilkTarih : Boolean read FilkTarih write TarihCreate;
   //  property sonTarih : Boolean read FsonTarih write TarihCreate;
  //   property Buton1 : TcxButtonKadir read FButon1 write setBtn1;
     property OnButonClick: TBClick read FOnButonClick write FOnButonClick;

end;




type
  TcxDonemComboKadir = class(TcxImageComboBox)
   private
     FItem : TcxImageComboBoxItem;
     FPopupYil : TPopupMenu;
     FBosOlamaz : Boolean;
     FItemList : string;
     FYil : string;
     FilkTarih : TDate;
     FsonTarih : TDate;
     procedure PopupClick(Sender : TObject);
   protected
   public
     constructor Create(AOwner: TComponent) ; override;
 //    destructor Destroy; override;
     procedure AfterConstruction; override;
     function getValueIlkTarih : string;
     function getValueSonTarih : string;
     function getYil : string;
     procedure setYil(const value : string);
     procedure ButonClick1(Sender: TObject);
     procedure DoEditValueChanged;override;
   published
     property BosOlamaz : Boolean read FBosOlamaz write FBosOlamaz;
     property ItemList : string read FItemList write FItemList;
     property Yil : string read getYil write setYil;
     property ilkTarih : TDate read FilkTarih write FilkTarih;
     property sonTarih : TDate read FsonTarih write FsonTarih;
end;




type
  TcxImageComboKadir = class(TcxImageComboBox)
   private
     FItem : TcxImageComboBoxItem;
     FTableName : string;
     FFilter : string;
     FConn : TADOConnection;
     FValueField : string;
     FDisplayField : string;
     FBosOlamaz : Boolean;
     FItemList : string;
     procedure setFilter(const value : string);
     function getFilter : string;
   protected
   public
     constructor Create(AOwner: TComponent) ; override;
   published
     property TableName : string read FTableName write FTableName;
     property Filter : string read getFilter write setFilter;
     property Conn : TADOConnection read FConn write FConn;
     property ValueField : string read FValueField write FValueField;
     property DisplayField : string read FDisplayField write FDisplayField;
     property BosOlamaz : Boolean read FBosOlamaz write FBosOlamaz;
     property ItemList : string read FItemList write FItemList;
end;


    TDoktorComboBox = class(TComboBox)
    private
      FColCount : integer;
      FCols : string;
      FColsW : string;
      FColbaslik : string;
      FTable : string;
      FWhere : string;
      FConn : TADOConnection;
      FSQLC : TADOQuery;
      Fstrings : TstringList;
      FstringsW : TstringList;
      FVersiyon : string;
      FLinC : TStrings;
      FCalistir : TGoster;
//      procedure SetImageIndex(Value: TImageIndex);
//      function GetVersiyon : string;
      procedure setLines(const value : TStrings);
      function getlines : TStrings;
      procedure dizaynEt(kolonlar : TStrings);

    protected
    public
      constructor Create(AOwner: TComponent) ; override;
      destructor Destroy; override;
      function ListeGetir : string;

  published
      property TColcount : integer read Fcolcount write Fcolcount;
    //  property TCols : string read Fcols write Fcols;
      property TColsW : string read FcolsW write FcolsW;
      property Table : string read Ftable write Ftable;
      property Where : string read FWhere write FWhere;
    //  property Colbaslik : string read FColbaslik write FColbaslik;
      property Conn : TADOConnection read FConn write FConn;
  //    property Versiyon : string read GetVersiyon;
      property Kolonlar : TStrings read FLinC write setLines;
      property Calistir : TGoster read FCalistir write FCalistir;
  end;



  TKadirEdit = class(TEdit)
   private
    FRenkEnter : TColor;
    FRenkCikis : TColor;
    FEnterlaGec : Boolean;
    FListeAc : TListeAc;
    FListeAcTus : TShortCut;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
   protected
   public
      CONSTRUCTOR Create(AOwner: TComponent); override;
 //     destructor Destroy; override;
   published
       property RenkEnter : Tcolor read FRenkEnter write FRenkEnter;
       property RenkCikis : Tcolor read FRenkCikis write FRenkCikis;
       property EnterlaGec : Boolean read FEnterlaGec write FEnterlaGec;
       property ListeAc : TListeAc read FListeAc write FlisteAc;
       property ListeAcTus : TShortCut read FListeAcTus write FListeAcTus;
  End;


type
   TKabulBilgi = record
    dosyaNo : string;
    gelisNo : string;
    detayNo : string;
    code : string;
    grup : string;
    kabulTarihi : string;
    kabulEden : string;
    durum : string;
    Icode : string;
    name : string;
    sira : string;
    yas : string;
    cins : string;
end;



type
   SonucBilgisi = record
    KabulNo : string;
    TestNo : string;
    Sonuc : string;
   end;
   ArraySonucBilgisi = array of SonucBilgisi;


type
  WSonuclar = ArraySonucBilgisi;
  TOnKaydetEvent = PROCEDURE(Sender: TObject; WSonuclar: ArraySonucBilgisi) OF OBJECT;


  TLabIslemleri = class(TComponent)
    private
      Fsonuclar : ArraySonucBilgisi;
      FKabulBilgi : TKabulBilgi;
      FConnectionstring : string;
      FTestAdet : integer;
      FOnKaydet : TOnKaydetEvent;
      FOnGuncelle : TNotifyEvent;
      procedure DiziSet(const value : integer);
    protected
    public
      constructor Create(AOwner: TComponent) ; override;
      destructor Destroy; override;
      function SonucKaydet : string;
      function KabulEt : string;
      function CihazTestKodu_To_LisTestKodu(code : string) : string;

    published
      property  OnKaydet : TOnKaydetEvent read FOnKaydet write FOnKaydet;
      property  OnGuncelle : TNotifyEvent read FOnGuncelle write FOnGuncelle;
    //  property sonuclar : ArraySonucBilgisi read Fsonuclar write Fsonuclar;
      property KabulBilgi : TKabulBilgi read FKabulbilgi write FKabulbilgi;
      property Connectionstring : string read Fconnectionstring write Fconnectionstring;
      property sonuclar : ArraySonucBilgisi read Fsonuclar write Fsonuclar;
      property TestAdet : integer read FTestAdet write Diziset;

  end;



type
  TGirisFormItem = class(TCollectionItem)
  private
    FCaption: string;
    FFieldName: string;
  //  Fparent : TdxLayoutGroup;
    Fgrup : string;
    Fuzunluk : integer;
    FZorunlu : Boolean;
    procedure Setparent(const Value: TdxLayoutGroup);

  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Caption : string read FCaption write FCaption;
    property FieldName: string read FFieldName write FFieldName;
 //   property parent: TdxLayoutGroup read Fparent write Setparent;
    property uzunluk: integer read Fuzunluk write Fuzunluk;
  end;

  TGirisFormItems = class(TOwnedCollection)
  private
    function GetItems(Index: Integer): TGirisFormItem;
    procedure SetItems(Index: Integer; const Value: TGirisFormItem);
  protected
    procedure InternalChanged;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TPersistent);
    function Add: TGirisFormItem;
    property Items[Index: Integer]: TGirisFormItem read GetItems write SetItems; default;
  end;


  TGirisFormCreateControl = class(TComponent)
    private
     FItems : TGirisFormItems;
     constructor Create(AOwner: TPersistent);
     procedure Assign(Source: TPersistent);
     destructor Destroy;
     procedure SetItems(const Value: TGirisFormItems);
    protected
    public
    published
     property Items: TGirisFormItems read FItems write SetItems;
  end;


type
   TMenuGorunum = record
    Kullanici : string;
    Menu : string;
    ID : integer;
    Izin : integer;
    KAYITID : integer;
    MainMenu : string;
    Kapsam : integer;
    imageIndex : integer;
    formId : integer;
    ShowTip : integer;
end;



procedure QuerySelect(Q: TADOQuery; sql:string);
procedure Split (const Delimiter: Char; Input: string; const Strings: TStrings) ;
function tarihFarki(tarih1,tarih2 : Tdate) : string;
function tarihal(t: tdate): string;
function tarihyap(t: string): tdate;
function KurumAdi(_kod : string) : string;

procedure Register;


var
  arama , aramaText : string;
  MenuItem : TMenuItem;
  Liste : TcxGridDBTableView;
  ListeBanded : TcxGridDBBandedTableView;
implementation

uses ComObj, Consts, RTLConsts, Themes;

 {*.RES,*.dres}

procedure Register;
begin
  RegisterComponents('Nokta', [TKadirLabel]);
  RegisterComponents('Nokta', [TKadirEdit]);
  RegisterComponents('Nokta', [TListeAc]);
  RegisterComponents('Nokta', [THastaBilgileriGroup]);
  RegisterComponents('Nokta', [TDoktorComboBox]);
  RegisterComponents('Nokta', [TKadirHastaBilgiPanel]);
  RegisterComponents('Nokta', [TLabIslemleri]);
  RegisterComponents('Nokta', [TMainMenuKadir]);
//  RegisterComponents('Nokta', [TMainMenuKadirItems]);
  RegisterComponents('Nokta', [TcxButtonEditKadir]);
  RegisterComponents('Nokta', [TcxButtonKadir]);
  RegisterComponents('Nokta', [TcxDateEditKadir]);
  RegisterComponents('Nokta', [TcxTextEditKadir]);
  RegisterComponents('Nokta', [TcxGridKadir]);
  RegisterComponents('Nokta', [TMenuItemModul]);
  RegisterComponents('Nokta', [TToolButtonKadir]);
  RegisterComponents('Nokta', [TFScxGrid]);
  RegisterComponents('Nokta', [TcxImageComboKadir]);
  RegisterComponents('Nokta', [TcxCheckBoxKadir]);
  RegisterComponents('Nokta', [TcxTopPanelKadir]);
  RegisterComponents('Nokta', [TcxDonemComboKadir]);
  RegisterComponents('Nokta', [TGirisFormCreateControl]);

  Classes.RegisterClass(TFScxGridDBTableView);
  Classes.RegisterClass(TdxNavBarKadirItem);
  Classes.RegisterClass(TGirisFormItem);
  Classes.RegisterClass(TGirisFormItems);



end;

constructor TGirisFormItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

procedure TGirisFormItem.Assign(Source: TPersistent);
begin
  if Source is TGirisFormItem then
    with TGirisFormItem(Source) do
    begin
      Self.FCaption := Caption;
      Self.FFieldName := FieldName;
   //   Self.Fparent := parent;
      Self.Fuzunluk := uzunluk ;
    end
  else
    inherited Assign(Source);
end;


procedure TGirisFormItem.Setparent(const Value: TdxLayoutGroup);
begin
 // if Fparent <> Value then
 // begin
  //  Fparent := Value;
 //   TGirisFormItems(Collection).InternalChanged;
 // end;
end;


function TGirisFormItems.GetItems(Index: Integer): TGirisFormItem;
begin
  Result := TGirisFormItem(inherited Items[Index]);
end;


procedure TGirisFormItems.SetItems(Index: Integer;
  const Value: TGirisFormItem);
begin
  inherited Items[Index] := Value;
end;

procedure TGirisFormItems.InternalChanged;
begin
  Changed;
end;

procedure TGirisFormItems.Update(Item: TCollectionItem);
begin
  with TGirisFormCreateControl(Owner) do
    Changed;
end;

constructor TGirisFormItems.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TGirisFormItem);
end;

function TGirisFormItems.Add: TGirisFormItem;
begin
  Result := TGirisFormItem(inherited Add);
end;


procedure TGirisFormCreateControl.SetItems(
  const Value: TGirisFormItems);
begin
  FItems.Assign(Value);
 // Changed;
end;

constructor TGirisFormCreateControl.Create(AOwner: TPersistent);
begin
  FItems := TGirisFormItems.Create(Self);
end;

destructor TGirisFormCreateControl.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TGirisFormCreateControl.Assign(Source: TPersistent);
begin
  if Source is TGirisFormCreateControl then
  begin
  //  BeginUpdate;
    try
      inherited Assign(Source);
      with TGirisFormCreateControl(Source) do
      begin
        Self.Items.Assign(Items);
      end;
    finally
    //  EndUpdate
    end
  end
  else
    inherited Assign(Source);
end;

procedure QuerySelect(Q: TADOQuery; sql:string);
begin
//    if Pos ('WHERE',AnsiUpperCase(sql)) <> 0
//    Then sql := StringReplace(sql,'WHERE','WITH(NOLOCK) WHERE',[rfReplaceAll,rfIgnoreCase])
//    else
//      if  (Pos ('GROUP BY',AnsiUpperCase(sql)) = 0)
//      and (Pos ('ORDER BY',AnsiUpperCase(sql)) = 0)
//      Then sql := sql + ' WITH(NOLOCK) ';


    Q.Close;
    Q.SQL.Clear ;
    if Copy(AnsiUppercase(sql) ,1, 6) = 'SELECT'
    Then sql := 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  '+ sql;
    Q.SQL.Add (sql);
//    Q.Prepare;
    Q.Open;
end;

procedure Split (const Delimiter: Char; Input: string; const Strings: TStrings) ;
begin
   Assert(Assigned(Strings)) ;
   Strings.Clear;
   Strings.Delimiter := Delimiter;
   Strings.DelimitedText := Input;
end;


function ayliktarih2(_ay_: string; _yil_: string = ''): Tdate;
var
  s: string;
  sp: Char;
  Tarih: Tdate;
  ay, yil, gun: word;

begin
  if _yil_ = '' Then
    _yil_ := copy(datetostr(date()), 7, 4);
  Tarih := strtodate('01.' + _ay_ + '.'+_yil_);

  sp := DateSeparator;
  s := '01' + sp + copy(tarihal(Tarih), 5, 2) + sp + copy(tarihal(Tarih), 1, 4);
  ay := strtoint(copy(tarihal(Tarih), 5, 2));

  inc(ay);
  if ay > 12 then
    ay := 1;
  yil := strtoint(copy(tarihal(Tarih), 1, 4));
  gun := 1;
  if (ay = 1) and (gun = 1) then
    inc(yil);
  Result := encodedate(yil, ay, gun) - 1;

end;

function tarihFarki(tarih1,tarih2 : Tdate) : string;
var
   yil1,yil2, aylik , gunluk  : double;
   fyil ,ay ,gun : integer;
   farkGun : double;
begin
     yil1 := strtoint(copy(tarihal(tarih1),1,4));
     yil2 := strtoint(copy(tarihal(tarih2),1,4));
     farkGun := (tarih1 - tarih2);

     fyil := floor((tarih1- tarih2) / 365);
     aylik := (floor(farkGun) mod 365);
     ay := floor(aylik /30);
     gunluk := (floor(aylik) mod 30);

     result := floattostr(fyil) + ',' + FloatToStr(ay) + ',' + FloatToStr(floor(gunluk));
end;

function tarihal(t: tdate): string;
var
 sonuct,s:string;
begin
 s := datetostr(t);
 result := copy(s,7,4)+copy(s,4,2)+copy(s,1,2);
end;

function tarihyap(t: string): tdate;
var
ds : char;
y,a,g : string;
begin
    ds := DateSeparator;
    y := copy(t,1,4);
    a := copy(t,5,2);
    g := copy(t,7,2);

    result := strtodate(g + ds + a + ds + y);

end;

function KurumAdi(_kod : string) : string;
var
  sql : string;
  ado : TADOQuery;
begin
  //sql := 'SELECT * FROM Kurumlar WHERE kurum = ' + _kod;
  //datalar.

end;



 (*
function TMenuItemKadir.GetItem(Index: Integer): TMenuItemKadir;
begin
  if FItems = nil then
    Error({$IFNDEF CLR}@{$ENDIF}SMenuIndexError);
  Result := TMenuItemKadir(FItems[Index]);
end;
   *)

constructor TcxImageComboKadir.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;


//function TcxDonemComboKadir.LookupKeyToEditValue(const AKey: TcxEditValue): TcxEditValue;
//begin
 // FilkTarih.EditValue := tarihyap(getValueIlkTarih);
 // FsonTarih.EditValue := tarihyap(getValueSonTarih);
//end;



procedure TcxDonemComboKadir.DoEditValueChanged;
begin
  inherited;
  FilkTarih := tarihyap(getValueIlkTarih);
  FsonTarih := tarihyap(getValueSonTarih);
end;


procedure TcxDonemComboKadir.ButonClick1(Sender : TObject);
begin
 // FilkTarih.EditValue := tarihyap(getValueIlkTarih);
 // FsonTarih.EditValue := tarihyap(getValueSonTarih);
//  if Assigned(OnClick) then OnClick(Self);

end;


function TcxDonemComboKadir.getYil : string;
begin
    Result := Fyil;
end;

procedure TcxDonemComboKadir.setYil(const value : string);
begin
  Fyil := value;
  if (Fyil <> '') and (Properties.Items.Count < 12)
  Then begin
    Properties.Items.Clear;
    FItem := Properties.Items.Add;
    FItem.Value := '01';FItem.Description := 'OCAK';
    FItem := Properties.Items.Add;
    FItem.Value := '02';FItem.Description := '�UBAT';
    FItem := Properties.Items.Add;
    FItem.Value := '03';FItem.Description := 'MART';
    FItem := Properties.Items.Add;
    FItem.Value := '04';FItem.Description := 'N�SAN';
    FItem := Properties.Items.Add;
    FItem.Value := '05';FItem.Description := 'MAYIS';
    FItem := Properties.Items.Add;
    FItem.Value := '06';FItem.Description := 'HAZ�RAN';
    FItem := Properties.Items.Add;
    FItem.Value := '07';FItem.Description := 'TEMMUZ';
    FItem := Properties.Items.Add;
    FItem.Value := '08';FItem.Description := 'A�USTOS';
    FItem := Properties.Items.Add;
    FItem.Value := '09';FItem.Description := 'EYL�L';
    FItem := Properties.Items.Add;
    FItem.Value := '10';FItem.Description := 'EK�M';
    FItem := Properties.Items.Add;
    FItem.Value := '11';FItem.Description := 'KASIM';
    FItem := Properties.Items.Add;
    FItem.Value := '12';FItem.Description := 'ARALIK';
  end;
end;

function TcxDonemComboKadir.getValueIlkTarih : string;
begin
    getValueIlkTarih :=  FYil + EditingValue + '01';
end;

function TcxDonemComboKadir.getValueSonTarih : string;
begin
 getValueSonTarih := tarihal(ayliktarih2(EditingValue,FYil));

end;
procedure TcxDonemComboKadir.PopupClick(Sender : TObject);
begin
  FYil := trim(stringReplace(TMenuItem(sender).Caption,'&','',[rfReplaceAll]));
end;

procedure TcxDonemComboKadir.AfterConstruction;
begin

end;


constructor TcxDonemComboKadir.Create(AOwner: TComponent);
var
  I ,yil : integer;
  item : TMenuItem;
begin
  inherited Create(AOwner);

  FPopupYil := TPopupMenu.Create(self);
  Self.PopupMenu := FPopupYil;

  yil := strtoint(copy(datetostr(date),7,4))+1;
 // Fyil := inttostr(yil);
//--  popupYil.Items.Clear;
  for I := 1 to 5 do
  begin
   yil := yil - 1;
   if FpopupYil.items.Find(inttostr(yil)) = nil
   Then Begin
     item := TMenuItem.Create(self);
     item.Caption := inttostr(yil);
    // item.Name := protokol + '-' + hasta;
     item.onClick := PopupClick;
     FpopupYil.Items.Insert(FpopupYil.Items.Count  , item);
   End;
  end;

end;

function TcxImageComboKadir.getFilter;
begin
  result := FFilter;
end;


procedure TcxImageComboKadir.setFilter(const value : string);
var
  ado : TADOQuery;
  Tlist : TstringList;
  i : integer;
begin
  FFilter := value;
  Properties.Items.Clear;

  if FConn <> nil
  then begin
    if FTableName = '' then exit;
    ado := TADOQuery.Create(nil);
    ado.Connection := FConn;
    try
      ado.SQL.Text := 'select ' + FValueField + ',' + FDisplayField + ' from ' + FTableName +
      ifthen(FFilter = '','',' where ' + FFilter ) + ' ORDER BY ' + FDisplayField;
      ado.Open;
    except
      ado.Free;
    end;

    while not ado.Eof do
    begin
        FItem := Properties.Items.add;
        FItem.Value := ado.Fields[0].AsString;
        FItem.Description := ado.Fields[1].AsString;
        ado.Next;
    end;

    if FBosOlamaz = False  then
    begin
        FItem := Properties.Items.add;
        FItem.Value := '';
        FItem.Description := 'Atanmam��';
    end;

    ado.close;
    ado.Free;
  end
  else
  begin
      TList := TStringList.Create;
      ExtractStrings([','],[],PChar(ItemList),Tlist);
  //    Split(',',ItemList,TList);
      for I := 0 to Tlist.Count - 1 do
      begin
        FItem := Properties.Items.add;
        FItem.Value := copy(Tlist[I],1,pos(';',Tlist[I])-1);
        FItem.Description := copy(Tlist[I],pos(';',Tlist[I])+1,200);
      end;
      TList.Free;
  end;

end;


function TcxTextEditKadir.GetSQLValue : string;
begin
  result := QuotedStr(self.EditingValue);
end;

function TcxCheckBoxKadir.GetSQLValue : string;
begin
  result := ifThen(self.EditingValue = True,Secili,SeciliDegil);
end;


function TcxDateEditKadir.GetValue(format : string = 'YYYYMMDD') : string;
var
  sonuct,s:string;
begin
  result := FormatDateTime(format,self.Date);
end;

function TcxDateEditKadir.GetSQLValue(format : string = 'YYYYMMDD') : string;
var
  sonuct,s:string;
begin
  result := QuotedStr(FormatDateTime(format,self.Date));
end;


class function TcxDateEditKadir.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomDateEditPropertiesKadir;
end;



procedure TcxCustomDateEditPropertiesKadir.ValidateDisplayValue(var ADisplayValue: TcxEditValue;
var AErrorText: TCaption; var AError: Boolean;
AEdit: TcxCustomEdit);
begin
   //
   inherited;
   if AError = True then
   begin
     AErrorText := 'Hatal� Tarih Aral��� : ' +
     datetostr(TcxDateEditKadir(AEdit).Properties.MinDate) + ' - ' +
     datetostr(TcxDateEditKadir(AEdit).Properties.MaxDate);
     ADisplayValue := '';
   end;
end;




constructor TcxGridKadir.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDataset := TADOQuery.Create(self);
  FDataset.AfterOpen := DatasetAfterOpen;
  FDataSource := TDataSource.Create(self);
  FDataSource.DataSet := FDataset;
  FPMenu := TPopupMenu.Create(self);
  MenuItem := TMenuItem.Create(FPMenu);
  MenuItem.Caption := 'Excel';
  MenuItem.Tag := 0;
  MenuItem.OnClick := TClick;
  FpMenu.Items.Add(MenuItem);
  PopupMenu := FPMenu;

  cxGridToTr;

 (*
  TcxGridDBTableView(TcxGrid(TPopupMenu(TMenuItem(self).GetParentMenu).PopupComponent).ActiveView).DataController.DataSource.dataset;
  if TPopupMenu(TcxGridDBTableView(TcxGridKadir(self).ActiveView).PopupMenu).Items.Count = 0
  then begin
    PopupMenu := FPMenu;
  end
  else
  begin

    TPopupMenu(TcxGridDBTableView(TcxGridKadir(self).ActiveView).PopupMenu).Items.Add(FPMenu.Items);

  //  for MenuItem in PopupMenu.items do
 //     begin
 //     end;

  end;
   *)



end;

(*
procedure TcxGridKadir.AfterConstruction;
begin
  inherited AfterConstruction;

   ListeBanded := TcxGridDBBandedTableView(TcxGridKadir(self).ActiveView);
end;
   *)

function TcxGridKadir.SelectedCellValue(ColonFieldName : string) : Values;
var
  Grid : TcxGridDBTableView;
  _Values_ : Values;
  i : integer;
begin
  Grid := TcxGridDBTableView(TcxGridKadir(self).ActiveView);
  SetLength(_Values_,0);
  SetLength(_Values_,Grid.Controller.SelectedRecordCount);
  for i := 0 to Grid.Controller.SelectedRecordCount - 1 do
  begin
    _Values_[i] := Grid.DataController.GetValue(
      Grid.Controller.SelectedRows[i].RecordIndex,
        Grid.DataController.GetItemByFieldName(ColonFieldName).Index);
  end;
  Result := _Values_;
end;

function TcxGridKadir.SelectedCellValue(ColonFieldName : string ; Row : integer) : Variant;
var
  Grid : TcxGridDBTableView;
begin
  Grid := TcxGridDBTableView(TcxGridKadir(self).ActiveView);
  SelectedCellValue := '';
  SelectedCellValue := Grid.DataController.GetValue(
    Grid.Controller.SelectedRows[Row].RecordIndex,
      Grid.DataController.GetItemByFieldName(ColonFieldName).Index);
end;

procedure TcxGridKadir.SelectedCellSetValue(ColonName : string ; Row : integer ; Value : Variant);
var
  Grid : TcxGridDBTableView;
begin
  Grid := TcxGridDBTableView(TcxGridKadir(self).ActiveView);
  Grid.BeginUpdate;
  Grid.DataController.SetValue(
        Grid.Controller.SelectedRows[Row].RecordIndex,
          Grid.DataController.GetItemByFieldName(ColonName).Index,Value);
  Grid.EndUpdate;
end;


procedure TcxGridKadir.DatasetAfterOpen(DataSet: TDataSet);
begin
  inherited;
   TcxGridDBTableView(ActiveView).DataController.DataSource := FDataSource;
end;


procedure TcxGridKadir.TClick(sender : TObject);
var
  SD : TSaveDialog;
begin
   Liste :=  TcxGridDBTableView(TcxGridKadir(self).ActiveView);
   case TMenuItem(sender).Tag of

     0 : begin
           SD := TSaveDialog.Create(nil);
           SD.FileName := ifThen(Self.ExcelFileName = '',GetParentForm(Self).Name,Self.ExcelFileName) + '.XLS';
           SD.Execute;
           ExportGridToExcel(SD.FileName, self);
         end;
   end;


end;



constructor TLabIslemleri.Create(AOwner: TComponent);
var
  reg : TREGISTRy;
begin
    inherited Create(AOwner);
    reg := Tregistry.Create;
    reg.OpenKey('Software\NOKTA\NOKTA',True);

    Fconnectionstring := 'Provider=SQLOLEDB.1;Password=1;Persist Security Info=False;User ID=sa;Initial Catalog=KLINIK;Data Source='
                         + reg.ReadString('servername');
    reg.CloseKey;
    reg.Free;

  //  SetLength(Fsonuclar,FTestAdet);
    
end;

destructor TLabIslemleri.Destroy;
begin
  try
  // FDosya := '';
    SetLength(Fsonuclar,0);
  finally
    inherited;
  end;
end;

function TLabIslemleri.SonucKaydet : String;
var
  Sonuclar : ArraySonucBilgisi;
  sql : string;
  ado : TADOQuery;
  conn : TADOConnection;
  i , j : integer;
begin
   conn := TADOConnection.Create(nil);
   conn.ConnectionString := Fconnectionstring;
   Conn.LoginPrompt := False;
   conn.Connected := True;
   ado := TADOQuery.Create(nil);
   ado.Connection := conn;
   j := 1;
   for i := 0 to length(FSonuclar) - 1 do
   begin
     try
        sql := 'update laboratuvar_sonuc ' +
               ' set sonuc1 = ' + QuotedStr(Fsonuclar[i].Sonuc) +
               ' where barkodNo = ' + QuotedStr(Fsonuclar[i].KabulNo) +
               ' and parametreadi = ' + QuotedStr(CihazTestKodu_To_LisTestKodu(Fsonuclar[i].TestNo)) +
               ' select @@rowcount ';


       QuerySelect(ado,sql);
       if ado.Fields[0].AsInteger > 0
       Then Begin
           SetLength(Sonuclar,j);
           sonuclar[j].KabulNo := Fsonuclar[i].Sonuc;
           Sonuclar[j].TestNo := Fsonuclar[i].TestNo;
           Sonuclar[j].KabulNo := Fsonuclar[i].KabulNo;
           inc(j);
       End;

     except
        result := '0001';
     end;
   end;

   IF Assigned(OnKaydet) THEN  OnKaydet (Self, Sonuclar);


   conn.Connected := False;
   ado.Free;
   conn.Free;
end;


function TLabIslemleri.CihazTestKodu_To_LisTestKodu(code : string) : string;
var
  sql : string;
  ado :TADOQuery;
  conn : TADOConnection;
begin
   conn := TADOConnection.Create(nil);
   conn.ConnectionString := Fconnectionstring;
   Conn.LoginPrompt := False;
   conn.Connected := True;
   ado := TADOQuery.Create(nil);
   ado.Connection := conn;

   sql := 'select parametreadi from laboratuvar_parametre where CihazTestKodu = ' + QuotedStr(code);
   QuerySelect(ado,sql);
   result := ado.Fields[0].AsString;

   ado.Free;


end;



function TLabIslemleri.Kabulet : String;
var
  sql : string;
  ado : TADOQuery;
  conn : TADOConnection;
  kabulNo : string;
begin
   conn := TADOConnection.Create(nil);
   conn.ConnectionString := Fconnectionstring;
   conn.LoginPrompt := false;
   conn.Connected := True;
   ado := TADOQuery.Create(nil);
   ado.Connection := conn;
   
   try
        sql := ' exec sp_YeniLabKabulNoAl ';
        QuerySelect(ado,sql);
        kabulNO := ado.Fields[0].AsString;

         sql := 'exec sp_YeniLabKabul ' +
                #39 + FKabulBilgi.dosyaNo + #39 + ',' +
                FKabulBilgi.gelisNo + ',' +
                FKabulBilgi.detayNo + ',' +
                #39 + FKabulBilgi.code + #39 + ',' +
                #39 + FKabulBilgi.grup + #39 + ',' +
                #39 + FKabulBilgi.kabulTarihi + #39 + ',' +
                #39 + FKabulBilgi.kabulEden + #39 + ',' +
                #39 + FKabulBilgi.durum + #39 + ',' +
                #39 + FKabulBilgi.Icode + #39 + ',' +
                #39 + FKabulBilgi.name + #39 + ',' +
                #39 + FKabulBilgi.sira + #39 + ',' +
                #39 + kabulNo + #39;

      //   QueryExec(ado,sql);
         result := '1'

   except
      result := '0001';

   end;

   ado.Free;

end;

procedure TLabIslemleri.DiziSet(const value : integer);
var
 s : string;
begin
    FTestAdet := value;
    SetLength(Fsonuclar,FTestAdet);


end;



constructor TMainMenuKadir.Create(AOwner: TComponent);
begin
  try
    inherited Create(AOwner);
  //  MenuGetir;
  finally
  end;
end;





(*
constructor TMainMenuKadirItems.Create(AOwner: TComponent);
begin
  try
    inherited Create(AOwner);
  finally
  end;
end;
*)


constructor THastaBilgileriGroup.Create(AOwner: TComponent);
begin
  try
    inherited Create(AOwner);

    FHb := THb.Create;

    HastaAdi := TEdit.Create(self);
    HastaAdi.Parent := self;
    HastaAdi.ParentFont := False;
    HastaAdi.Top := 20;
    HastaAdi.Left := 50;
    HastaAdi.TabOrder := 0;
    HastaAdi.TabStop := True;
    HAstaAdi.Text := 'HastaAdi';

    HastaSoyadi := TEdit.Create(self);
    HastaSoyadi.Parent := self;
    HastaSoyadi.ParentFont := False;
    HastaSoyadi.Top := 50;
    HastaSoyadi.Left := 50;
    HastaSoyadi.TabOrder := 0;
    HastaSoyadi.TabStop := True;
    HastaSoyadi.Text := 'HastaSoyadi';


    FHastaAdiFont := THastaAdiFont.Create;
    FHastaSoyaAdi := THastaAdiFont.Create;


  finally
   //  HastaAdi.Free;
  end;

   (*
    HastaSoyadi := TEdit.Create(nil);
    HastaSoyadi.Parent := self;
    HastaSoyadi.Top := 60;
    HastaSoyadi.Left := 50;
    HastaSoyadi.TabStop := True;
    HastaSoyadi.TabOrder := 1;

     *)

end;

(*
procedure THastaBilgileriGroup.WMFontChange(var Message: TMessage);
begin
  inherited;
  Perform(CM_FONTCHANGE, 0, 0);
end;
  *)

procedure THastaBilgileriGroup.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if HandleAllocated then Perform(WM_SETFONT, Font.Handle, 0);
  NotifyControls(CM_PARENTFONTCHANGED);


end;



(*
destructor THastaBilgileriGroup.Destroy;
begin
   FHastaAdi.Free;
end;
  *)

 (*
function THastaBilgileriGroup.setHastaAdi : Tedit;
begin
    FHastaAd.Assign(value);
end;
   *)

procedure THastaBilgileriGroup.setHastaAdiFont (const value : TFont);
begin
    FHastaAdiFont.Assign(value);
    HastaAdi.Font := FHastaAdiFont;
    IF Assigned(OnHastaAdiFontChange) THEN  OnHastaAdiFontChange(Self, HHastaAdiFont);
    ShowMessage('a');
end;

procedure THastaBilgileriGroup.SetHb(const Value: THb);
begin
  FHb.Assign(Value);
end;

function THastaBilgileriGroup.GetHastaAdiFont : TFont;
begin
   result := HastaAdi.Font;
end;

procedure THastaBilgileriGroup.setHastaSoyadiFont (const value : TFont);
begin
    FHastaSoyaAdi.Assign(value);
    HastaSoyadi.Font := FHastaSoyaAdi;
   // IF Assigned(OnHastaAdiFontChange) THEN  OnHastaAdiFontChange(Self, HHastaAdiFont);

end;

function TMainMenuKadir.MenuClick(_tag_ : integer) : integer;
var
  i,r , w: integer;
begin
   MenuClick := _tag_;
end;

(*
function TMainMenuKadir.GetDataSource: TDataSource;
begin
  Result := FDataSource;
end;


procedure TMainMenuKadir.SetDataSource(const Value: TDataSource);
begin
 // if IsLinkedTo(Value) then DatabaseError(SCircularDataLink, Self);
  FDataSource := Value;
end;
  *)

procedure TMainMenuKadir.LinkClick(Sender: TObject; ALink: TdxNavBarItemLink);
begin
  MenuId := ALink.Item.Tag;
end;

procedure TMainMenuKadir.TimerShowTimer(Sender: TObject);
begin
  left := left + Slite;
  if left >= 0 then TimerShow.Enabled := false;
end;

procedure TMainMenuKadir.TimerGizleTimer(Sender: TObject);
begin
  left := left - Slite;
  if left <= -1 * Width then TimerGizle.Enabled := false;
end;


procedure TMainMenuKadir.Goster;
begin
  TimerShow.Enabled := True;
end;

procedure TMainMenuKadir.Gizle;
begin
  TimerGizle.Enabled := True;
end;


function TMainMenuKadir.getTagC : integer;
begin
    getTagC := MenuId;
end;

procedure TMainMenuKadir.setTagC(const value : integer);
begin
    FTagC := value;
end;


procedure TMainMenuKadir.ActionListExecute(Sender: TObject);
begin
end;


function TMainMenuKadir.TusKontrol(tus : string) : integer;
var
   sql : string;
   ado : TADOQuery;
begin
  try
   ado := TADOQuery.Create(nil);
   ado.Connection := FConn;
   sql := 'select * from UserMenuSettings U ' +
          ' join MenuIslem M on M.KAYITID = U.ID ' +
          ' where Kullanici = ' + QuotedStr(FKullaniciAdi) + ' and shortCut = ' + QuotedStr(tus) + ' and Izin = 1 ';
   ado.SQL.Text := sql;
   ado.Open;

   if not ado.eof
   then
    result := ado.FieldByName('KAYITID').AsInteger
   else result := 0;

   ado.Free;
  except
   result := 0;
   ado.Free;
   exit;
  end;


end;



procedure TMainMenuKadir.MenuGetir;
var
  i,r , w , u , ug : integer;
  sql : string;
  ado : TADOQuery;
  _action_ : TAction;
  actItem : TActionClientItem;
  tmpActItem : TActionClientItem;
  act : TCustomAction;
  MenuGorunum : array of TMenuGorunum;
  MenuSatir : TMenuGorunum;
  ItemKadir : TdxNavBarKadirItem;

function MenuSatiriVar(ID : integer) : Boolean;
var
 I : integer;
begin
  MenuSatiriVar := False;
  for I := 0 to length(MenuGorunum) - 1 do
  begin
    if (MenuGorunum[I].KAYITID = ID) and (MenuGorunum[I].Izin = 1)  then
    begin
      MenuSatiriVar := True;
      Break;
    end;
  end;
end;

begin
 // TimerShow := TTimer.Create(self);
  //TimerGizle := TTimer.Create(self);
  TimerShow.Interval := 1;
  TimerGizle.Interval := 1;
  TimerShow.OnTimer  := TimerShowTimer;
  TimerGizle.OnTimer := TimerGizleTimer;

 // OnLinkClick := LinkClick;
  if ado = nil then ado := TADOQuery.Create(nil);
  ado.Connection := FConn;

  try
   sql := 'SELECT US.*,M.* FROM UserGroupMenuSettings US ' +
          'join MenuIslem M on M.KAYITID = US.ID ' +
          'join Users U on U.Grup = US.kullanici ' +
          'WHERE U.Kullanici = ' + QuotedStr(FKullaniciAdi);
   QuerySelect(ado,sql);

   u := ado.RecordCount;
   SetLength(MenuGorunum,0);
   i := 0;
   if u > 0
   then begin
     SetLength(MenuGorunum,u);
     while not ado.Eof do
     begin
         if MenuSatiriVar(ado.FieldByName('KAYITID').AsInteger) = False
         then begin
           MenuSatir.Kullanici := ado.FieldByName('Kullanici').AsString;
           MenuSatir.Menu := ado.FieldByName('Menu').AsString;
           MenuSatir.Izin := ado.FieldByName('Izin').AsInteger;
           MenuSatir.KAYITID := ado.FieldByName('KAYITID').AsInteger;
           MenuSatir.MainMenu := ado.FieldByName('MainMenu').AsString;
           MenuSatir.Kapsam := ado.FieldByName('Kapsam').AsInteger;
           MenuSatir.imageIndex := ado.FieldByName('imageIndex').AsInteger;
           MenuSatir.formId := ado.FieldByName('FormTag').AsInteger;
           MenuSatir.ShowTip := ado.FieldByName('ShowTip').AsInteger;
           MenuGorunum[i] := MenuSatir;
         end;
         inc(i);
         ado.Next;
     end;
   end;
  except
    SetLength(MenuGorunum,0);
  end;


  try
   sql := 'select * from UserMenuSettings U join MenuIslem M on M.KAYITID = U.ID where Kullanici = ' + QuotedStr(FKullaniciAdi);
   QuerySelect(ado,sql);
   ug := ado.RecordCount;
   u := u + ug;
   if ug > 0
   then begin
     SetLength(MenuGorunum,u);
     while not ado.Eof do
     begin
         if MenuSatiriVar(ado.FieldByName('KAYITID').AsInteger) = False
         then begin
           MenuSatir.Kullanici := ado.FieldByName('Kullanici').AsString;
           MenuSatir.Menu := ado.FieldByName('Menu').AsString;
           MenuSatir.Izin := ado.FieldByName('Izin').AsInteger;
           MenuSatir.KAYITID := ado.FieldByName('KAYITID').AsInteger;
           MenuSatir.MainMenu := ado.FieldByName('MainMenu').AsString;
           MenuSatir.Kapsam := ado.FieldByName('Kapsam').AsInteger;
           MenuSatir.imageIndex := ado.FieldByName('imageIndex').AsInteger;
           MenuSatir.ShowTip := ado.FieldByName('ShowTip').AsInteger;
           MenuSatir.formId := ado.FieldByName('FormTag').AsInteger;
           MenuGorunum[i] := MenuSatir;
         end;
         inc(i);
         ado.Next;
     end;
   end;
  except
    SetLength(MenuGorunum,0);
  end;

  if Length(MenuGorunum) = 0 then exit;


  Groups.Clear;
  Items.Clear;
  ado.First;
  i := 0;
  for MenuSatir in MenuGorunum do
  begin
   if MenuSatir.Kapsam = 0
   then begin
     Groups.Add.index := i;
     Groups[i].Caption := MenuSatir.MainMenu;
     Groups[i].Tag := MenuSatir.KAYITID;
     Groups[i].SmallImageIndex := MenuSatir.imageIndex;
     Groups[i].LargeImageIndex := MenuSatir.imageIndex;
     Groups[i].UseSmallImages := false;
     Groups[i].Visible := Boolean(MenuSatir.Izin);
     inc(i);
   end;
   ado.Next;
  end;

 // Items := MainMenuItemsKadir;
  r := 0;
  for MenuSatir in MenuGorunum do
  begin
   if MenuSatir.Kapsam  <> 0
   then begin
     Items.Add.Index := r;
     Items[r].Caption := MenuSatir.MainMenu;
     Items[r].Hint := MenuSatir.MainMenu;
     Items[r].Tag := MenuSatir.KAYITID;
     Items[r].SmallImageIndex := MenuSatir.imageIndex;
     Items[r].Visible := Boolean(MenuSatir.Izin);
     Items[r].FormId := MenuSatir.formId;
     Items[r].ShowTip := MenuSatir.ShowTip;

     for i := 0 to Groups.Count - 1 do
     begin
       if Groups[i].Tag = MenuSatir.Kapsam  then
        Groups[i].CreateLink(items[r]);
     end;
     inc(r);
   end;

  end;

  for i := 0 to Groups.Count - 1 do
  begin
     Groups[i].Expanded := false;
  end;

  ado.Close;
  ado.Free;

end;



function THastaBilgileriGroup.GetHastaSoyadiFont : TFont;
begin
   result := HastaSoyadi.Font;
end;




function TKadirHastaBilgiPanel.Donustur : string;
var
 sql , kurum ,kurumadi,  Hasta , Cins : string;
 ado : TADOQuery;
 ch : string;
 yas : string;
 dt ,_now_ : Tdate;

begin
   ado := TADOQuery.Create(nil);
   ado.Connection := FConn;

   sql := 'select * from hastaKart where dosyaNO = ' + QuotedStr(FGiris);
   QuerySelect(ado,sql);
   Hasta := ado.fieldbyname('HASTAADI').AsString + ' ' + ado.fieldbyname('HASTASOYADI').AsString;
   dt := tarihyap(ado.fieldbyname('DOGUMTARIHI').AsString);
   Cins := IfThen(ado.fieldbyname('CINSIYETI').AsString = '0','ERKEK','KADIN');
   kurum := ado.fieldbyname('Kurum').AsString;

   sql := 'select ADI1 from Kurumlar where kurum = ' + #39 + kurum + #39;
   QuerySelect(ado,sql);
   kurumadi := ado.fieldbyname('ADI1').AsString;


   if FSonuc = psYan
   Then ch := ' - ';

   _now_ := date;
   yas := tarihFarki(_now_,dt);


   Caption := Hasta + ' - ' + Cins + ' - ' + yas + ' - ' + kurumadi;




   ado.Free;



end;


constructor TDoktorComboBox.Create(AOwner: TComponent);
var
  L : TStrings;
begin
    inherited Create(AOwner);
    FLinC := TStringList.Create;
end;

destructor TDoktorComboBox.Destroy;
begin
      inherited;
      FLinC.Free;
end;


procedure TDoktorComboBox.setLines(const value : TStrings);
begin
    FLinC.Assign(value);
end;

function TDoktorComboBox.getlines : TStrings;
begin
    Result := FlinC;
end;


function TDoktorComboBox.ListeGetir : string;
var
  sql : string;
  ado : TADOQuery;
  r , x,j : integer;
begin

    if FlinC.Count = 0 then exit;

    ado := TADOQuery.Create(nil);

 //   Fstrings := TStringList.Create;


    ado.Connection := FConn;
    x := FlinC.Count;

    sql := 'select * from ' + Ftable;
  (*
    if Fwhere <> ''
    Then
     sql := sql + ' where ' + lst[FFilterCol] + ' like ' + QuotedStr(Fwhere);
    *)
    QuerySelect(ado,sql);

    dizaynEt(FlinC);

    Items.Clear;
    while not ado.Eof do
    begin
      Items.Add(ado.fieldbyname(FlinC[0]).AsString + ' - ' + ado.fieldbyname(FlinC[1]).AsString);
      ado.Next;
    end;


    Result := '0000';

    ado.Free;
    //Lst.Free;
   // lstW.Free;

end;

procedure TDoktorComboBox.dizaynEt(kolonlar : TStrings);
begin


end;



constructor TListeAc.Create(AOwner: TComponent);
var
  L : TStrings;

begin
    inherited Create(AOwner);
    FGrup := False;
    FLin := TStringList.Create;
    Flin1 := TStringList.Create;

end;


destructor TListeAc.Destroy;
begin
      inherited;
      FLin.Free;
      Flin1.Free;

end;





procedure TListeAc.setLines(const value : TStrings);
begin

    FLin.Assign(value);

end;

function TListeAc.getlines : TStrings;
begin
    Result := Flin;
end;




procedure TListeAc.setBiriktir(const value : Boolean);
begin
    FBiriktirmeliSecim := value;
 (*
    if FBiriktirmeliSecim
    then begin
      frmListeAc.Biriktir := True;
      frmListeAc.cxSecimGrid.Visible := True;

    end
    else begin
      frmListeAc.Biriktir := False;
      frmListeAc.cxSecimGrid.Visible := True;

    end;
   *)

end;

function TListeAc.getBiriktir : Boolean;
begin
    Result := FBiriktirmeliSecim;
end;


procedure TListeAc.setLines1(const value : TStrings);
begin
    Flin1.Assign(value);
end;

function TListeAc.getlines1 : TStrings;
begin
    Result := Flin1;
end;

procedure TListeAc.SetImageIndex(Value: TImageIndex);
begin


  if FButtonImajIndex <> Value then
  begin
    FButtonImajIndex := Value;


  end;
end;

function TListeAc.Getversiyon : string;
begin
     Result := 'Ver 1.0 Nokta Yaz�l�m';

end;

procedure TListeAc.Split (const Delimiter: Char; Input: string; const Strings: TStrings) ;
begin
   Assert(Assigned(Strings)) ;
   Strings.Clear;
   Strings.Delimiter := Delimiter;
   Strings.DelimitedText := Input;
end;


procedure TListeAc.QuerySelect(Q: TADOQuery; sql:string);
begin
//    if Pos ('WHERE',AnsiUpperCase(sql)) <> 0
//    Then sql := StringReplace(sql,'WHERE','WITH(NOLOCK) WHERE',[rfReplaceAll,rfIgnoreCase])
//    else
//      if  (Pos ('GROUP BY',AnsiUpperCase(sql)) = 0)
//      and (Pos ('ORDER BY',AnsiUpperCase(sql)) = 0)
//      Then sql := sql + ' WITH(NOLOCK) ';


    Q.Close;
    Q.SQL.Clear ;
    if Copy(AnsiUppercase(sql) ,1, 6) = 'SELECT'
    Then sql := 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  '+ sql;
    Q.SQL.Add (sql);
//    Q.Prepare;
    Q.Open;
end;


function TListeAc.ListeGetir : ArrayListeSecimler;
var
  sql : string;
  ado : TADOQuery;
  r , x,j : integer;
  lst,LstW,LstColB : TStringList;
 // ListeAc1 : TfrmListeAc;

begin

    if FcolsW = ''
    Then exit;

    //if Fcolcount = 0 then exit;
    if Flin.Count = 0 then exit;

    ado := TADOQuery.Create(nil);

//    Fstrings := TStringList.Create;
    FstringsW := TStringList.Create;
    Application.CreateForm(TfrmListeAc, frmListeAc);


    frmListeAc.pnlTitle.Color := FbaslikRenk;
    frmListeAc.pnlOnay.Color := FDipRenk;

//    frmListeAc.btnSec1.Images := FImajList;
//    frmListeAc.btnSec1.ImageIndex := FButtonImajIndex;


    ado.Connection := FConn;

//   lst := TStringList.Create;
   lstW := TStringList.Create;
 //  LstColB := TStringList.Create;

 //  Split(',',Fcols,lst);
   Split(',',FcolsW,lstW);
 //  Split(',',FColbaslik,LstColB);
   x := Flin.Count;
 //  lst.Free;

   sql := 'select * from ' + Ftable;
   if Fwhere <> ''
   Then
     sql := sql + ' where ' + FWhere;

   if Ffilter <> ''
   Then
     if FWhere = ''
     Then
      sql := sql + ' where '+ Flin[FFilterCol] + ' like ' + QuotedStr(FFilter)
     Else
      sql := sql + ' and '+ Flin[FFilterCol] + ' like ' + QuotedStr(FFilter);


   if FSiralamaKolonu <> ''
   Then
    sql := sql + ' order by ' + FSiralamaKolonu;




   QuerySelect(ado,sql);

   frmListeAc.Caption := FListeBaslik;
   frmListeAc.pnlTitle.Caption := FListeBaslik;
   frmListeAc.DataSource1.DataSet := ado;
   frmListeAc.dizaynEt(Flin,lstW,Flin1, Ffiltercol,FGrupCol,FGrup,FBiriktirmeliSecim);

   frmListeAc.Liste.ViewData.DataController.Filter.Options :=
   frmListeAc.Liste.ViewData.DataController.Filter.Options + [fcoCaseInsensitive];
   frmListeAc.cxGrid1.LookAndFeel.SkinName := FSkinName;
   frmListeAc.cxGrid2.LookAndFeel.SkinName := FSkinName;
   frmListeAc.btnSec1.LookAndFeel.SkinName := SkinName;

   frmListeAc.ShowModal;

   if frmListeAc.tus = 0
   Then Begin
     r := frmListeAc.Liste.ViewData.DataController.GetFocusedRecordIndex;
     SetLength(Fstrings,0);
     try
       Fstrings := frmListeAc.strings;
     except
     end;
     if length(Fstrings) = 0
     then
     SetLength(Fstrings,1);
     Result := Fstrings;
   End
   Else
   Begin
    // if length(Fstrings) = 0
    // then
     SetLength(Fstrings,0);
     Result := Fstrings;
   End;


   ado.Free;
//   Lst.Free;
   lstW.Free;
   frmListeAc.Free;

end;


constructor  TKadirEdit.Create(AOwner: TComponent);
begin
    inherited;
    FEnterlaGec := False;


end;

procedure TKadirEdit.CMEnter(var Message: TCMEnter);
begin
     inherited;
     Color := FRenkEnter;
end;

procedure TKadirEdit.CMExit(var Message: TCMEnter);
begin
     inherited;
     Color := FRenkCikis;
end;


constructor TcxButtonEditKadir.Create(AOwner: TComponent);
begin
    inherited;
    FListeAcTus := 0;
    FBosOlamaz := False;
end;

constructor TcxTextEditKadir.Create(AOwner: TComponent);
begin
    inherited;
    FBosOlamaz := false;
end;

constructor TcxDateEditKadir.Create(AOwner: TComponent);
begin
    inherited;
    FBosOlamaz := false;
    FValueTip := tvString;
end;

constructor TcxCheckBoxKadir.Create(AOwner: TComponent);
begin
    inherited;
    FBosOlamaz := false;
end;



procedure TcxTopPanelKadir.ButonClick(Sender: TObject);
begin
 if Assigned(OnButonClick) then OnButonClick(Self,TcxButtonKadir(sender).Tag);
end;

function TcxTopPanelKadir.GetValue(var tarih2 : string) : string;
begin
  tarih2 := sonTarih.GetValue;
  GetValue := ilkTarih.GetValue;
end;

function TcxTopPanelKadir.getButon1Goster;
begin
  Result := FButon1Goster;
end;

procedure TcxTopPanelKadir.setButon1Goster(const value : Boolean);
begin
   FButon1Goster := value;
   Btn1.Visible := FButon1Goster;
   Btn1.Caption := FButon1Caption;
end;

function TcxTopPanelKadir.getButon2Goster;
begin
  Result := FButon2Goster;
end;

procedure TcxTopPanelKadir.setButon2Goster(const value : Boolean);
begin
   FButon2Goster := value;
   Btn2.Visible := FButon2Goster;
   Btn2.Caption := FButon2Caption;
end;

constructor TcxTopPanelKadir.Create(AOwner: TComponent);
begin
    try
      inherited Create(AOwner);
      Btn1 := TcxButtonKadir.Create(self);
      Btn1.Parent := self;
      Btn1.Align := alLeft;
      Btn1.Tag := -1;
      Btn1.Visible := True;
      Btn1.LookAndFeel.SkinName := 'UserSkin';
      Btn1.LookAndFeel.NativeStyle := False;
      Btn1.OnClick := ButonClick;

      Btn2 := TcxButtonKadir.Create(self);
      Btn2.Parent := self;
      Btn2.Align := alLeft;
      Btn2.Tag := -2;
      Btn2.Visible := True;
      Btn2.LookAndFeel.SkinName := 'UserSkin';
      Btn2.LookAndFeel.NativeStyle := False;
      Btn2.OnClick := ButonClick;

      ilkTarih := TcxDateEditKadir.Create(self);
      ilkTarih.Parent := self;
      ilkTarih.Align := alLeft;
      ilkTarih.Properties.Alignment.Horz := taCenter;
    //  ilkTarih.Properties.Alignment.Vert := taVCenter;
      ilkTarih.LookAndFeel.SkinName := 'UserSkin';
      ilkTarih.LookAndFeel.NativeStyle := False;

      sonTarih := TcxDateEditKadir.Create(self);
      sonTarih.Parent := self;
      sonTarih.Align := alLeft;
      sonTarih.Properties := ilkTarih.Properties;
      sonTarih.LookAndFeel.SkinName := 'UserSkin';
      sonTarih.LookAndFeel.NativeStyle := False;


    finally

    end;
end;




procedure TcxButtonEditKadir.DoEditKeyDown(var Key: Word; Shift: TShiftState);
var
   Form: TCustomForm;
begin
    inherited;

    key := 0;
    (*
    if key = FListeAcTus
    Then Begin
       key := 13;
       try
        text := ListeAc.ListeGetir[0].kolon1;
       except
       end;
    End;
      *)
end;

procedure TKadirEdit.CNKeyDown(var Message: TWMKeyDown);
var
   Form: TCustomForm;
   key : word;
   Shift: TShiftState;
begin
    inherited;


    if Message.CharCode = FListeAcTus
    Then Begin
       key := 13;
       try
        text := ListeAc.ListeGetir[0].kolon1;
       except
       end;
       OnKeyDown(self,key,Shift);
       Message.CharCode := 13;
    End;


    if FEnterlaGec = True
    Then
      if Message.CharCode = VK_RETURN
      Then  Begin
        Message.CharCode := 0;
        Form := GetParentForm(Self);
        Form.Perform(WM_NEXTDLGCTL, 0, 0);

      End;



      
end;

constructor  TKadirLabel.Create(AOwner: TComponent);
begin
    inherited;
//    FGiris := '';
end;

destructor TKadirLabel.Destroy;
begin
  try

  finally
    inherited;
  end;
end;


procedure TKadirLabel.setGiris(const value : string);
begin
   FGiris := value;
end;

function TKadirLabel.getGiris : string;
begin
  Result := FGiris;
  Donustur;
end;


function TKadirLabel.Donustur : string;
var
  ado : TADOQuery;
  sql : string;
  tam,ondalik : double;
begin

     ado := TADOQuery.Create(nil);
     ado.Connection := FConn;

     if FDonusum = dsDoktorKodToAdi
     Then
       sql := 'select DoktorAdi from Doktorlar where Kod = ' + QuotedStr(FGiris);
     if FDonusum = dsBransKoduToadi
     Then
       sql := 'select BransAdi from SERVISLER where Kodu = ' + QuotedStr(Giris);

     if FDonusum = dsRakamToYazi
     Then Begin
       try
        if pos('.',FGiris) > 0
        Then Begin
         tam := strtofloat(copy(FGiris,1, pos('.',FGiris)));
         ondalik := strtofloat(copy(FGiris,pos('.',FGiris)+1,2));
         Caption := Param(tam) + ' Tl ' + Param(ondalik) + ' Kr';
        End
        Else
        Begin
         tam := strtofloat(FGiris);
         Caption := Param(tam) + ' Tl ';
        End;
       except
         Caption := '';
       end;
         if Assigned(OnDonustur) then OnDonustur(Self,FGiris);
         exit;
     End;


     if FDonusum = dsTanimToadi
     Then
         sql := 'select SLT from Hizmet_Gruplari where SLB = ' + QuotedStr(FGiris);

       QuerySelect(ado,sql);
       if not ado.Eof
       Then Caption := ado.Fields[0].AsString else Caption := 'Sonu� Yok';
       


    ado.Free;
    if Assigned(OnDonustur) then OnDonustur(Self,FGiris);
end;

(*
function TKadirLabel.SonucKaydet : String;
var
  sql : string;
  i : integer;
begin
        FRenk := clYellow;
        IF Assigned(OnRenkChange) THEN  OnRenkChange(Self, Renk);
        Kaydet;

end;
*)

procedure TcxGridKadir.cxGridToTr;
begin
  { ******************************************************************** }
  { cxGridStrs }
  { ******************************************************************** }
  // scxGridRecursiveLevels = 'You cannot create recursive levels';
  cxSetResourceString(@scxGridRecursiveLevels,
    'Yinelemeli seviyeler olu�turamazs�n�z');
  // scxGridDeletingConfirmationCaption = 'Confirm';
  // cxSetResourceString(@scxGridDeletingConfirmationCaption, 'Onayla');
  // scxGridDeletingFocusedConfirmationText = 'Delete record?';
  cxSetResourceString(@scxGridDeletingFocusedConfirmationText,
    'Kay�t silinsin mi ?');
  // scxGridDeletingSelectedConfirmationText = 'Delete all selected records?';
  cxSetResourceString(@scxGridDeletingSelectedConfirmationText,
    'Se�ili t�m kay�tlar silinsin mi ?');
  // scxGridNoDataInfoText = '<No data to display>';
  cxSetResourceString(@scxGridNoDataInfoText, '<G�sterilecek kay�t yok>');
  // scxGridNewItemRowInfoText = 'Click here to add a new row';
  cxSetResourceString(@scxGridNewItemRowInfoText,
    'Yeni sat�r eklemek i�in buraya t�klay�n');
  // scxGridFilterIsEmpty = '<Filter is Empty>';
  cxSetResourceString(@scxGridFilterIsEmpty, '<Filtre bo�>');
  // scxGridCustomizationFormCaption = 'Customization';
  cxSetResourceString(@scxGridCustomizationFormCaption, '�zelle�tirme');
  // scxGridCustomizationFormColumnsPageCaption = 'Columns';
  cxSetResourceString(@scxGridCustomizationFormColumnsPageCaption, 'S�tunlar');
  // scxGridGroupByBoxCaption = 'Drag a column header here to group by that column';
  cxSetResourceString(@scxGridGroupByBoxCaption,
    'Gruplamak istedi�iniz kolonu buraya s�r�kleyin');
  // scxGridFilterCustomizeButtonCaption = 'Customize...';
  cxSetResourceString(@scxGridFilterCustomizeButtonCaption, '�zelle�tir');
  // scxGridColumnsQuickCustomizationHint = 'Click here to select visible columns';
  cxSetResourceString(@scxGridColumnsQuickCustomizationHint,
    'G�r�n�r s�tunlar� se�mek i�in t�klay�n');
  // scxGridCustomizationFormBandsPageCaption = 'Bands';
  cxSetResourceString(@scxGridCustomizationFormBandsPageCaption, 'Bantlar');
  // scxGridBandsQuickCustomizationHint = 'Click here to select visible bands';
  cxSetResourceString(@scxGridBandsQuickCustomizationHint,
    'G�r�n�r bantlar� se�mek i�in t�klay�n');
  // scxGridCustomizationFormRowsPageCaption = 'Rows';
  cxSetResourceString(@scxGridCustomizationFormRowsPageCaption, 'Sat�rlar');
  // scxGridConverterIntermediaryMissing = 'Missing an intermediary component!'#13#10'Please add a %s component to the form.';
  cxSetResourceString(@scxGridConverterIntermediaryMissing,
    'Bulunamayan arac� bile�en!'#13#10'L�tfen bir %s bile�eni forma ekleyin.');
  // scxGridConverterNotExistGrid = 'cxGrid does not exist';
  cxSetResourceString(@scxGridConverterNotExistGrid, 'cxGrid yok');
  // scxGridConverterNotExistComponent = 'Component does not exist';
  cxSetResourceString(@scxGridConverterNotExistComponent, 'Bile�en yok');
  // scxImportErrorCaption = 'Import error';
  cxSetResourceString(@scxImportErrorCaption, '��e aktar�m hatas�');
  // scxNotExistGridView = 'Grid view does not exist';
  cxSetResourceString(@scxNotExistGridView, 'Grid g�r�n�m� yok');
  // scxNotExistGridLevel = 'Active grid level does not exist';
  cxSetResourceString(@scxNotExistGridLevel, 'Ge�erli grid seviyesi yok');
  // scxCantCreateExportOutputFile = 'Can''t create the export output file';
  cxSetResourceString(@scxCantCreateExportOutputFile,
    'D��a aktar�lacak dosya olu�turulam�yor');
  // cxSEditRepositoryExtLookupComboBoxItem = 'ExtLookupComboBox|Represents an ultra-advanced lookup using the QuantumGrid as its drop down control';
  // scxGridChartValueHintFormat = '%s for %s is %s'; // series display text, category, value

  { ******************************************************************** }
  { cxFilterConsts }
  { ******************************************************************** }

  // // base operators
  // cxSFilterOperatorEqual = 'equals';
  cxSetResourceString(@cxSFilterOperatorEqual, 'e�it');
  // cxSFilterOperatorNotEqual = 'does not equal';
  cxSetResourceString(@cxSFilterOperatorNotEqual, 'e�it de�il');
  // cxSFilterOperatorLess = 'is less than';
  cxSetResourceString(@cxSFilterOperatorLess, 'k���k');
  // cxSFilterOperatorLessEqual = 'is less than or equal to';
  cxSetResourceString(@cxSFilterOperatorLessEqual, 'k���k veya e�it');
  // cxSFilterOperatorGreater = 'is greater than';
  cxSetResourceString(@cxSFilterOperatorGreater, 'b�y�k');
  // cxSFilterOperatorGreaterEqual = 'is greater than or equal to';
  cxSetResourceString(@cxSFilterOperatorGreaterEqual, 'b�y�k veya e�it');
  // cxSFilterOperatorLike = 'like';
  cxSetResourceString(@cxSFilterOperatorLike, 'i�erir');
  // cxSFilterOperatorNotLike = 'not like';
  cxSetResourceString(@cxSFilterOperatorNotLike, 'i�ermez');
  // cxSFilterOperatorBetween = 'between';
  cxSetResourceString(@cxSFilterOperatorBetween, 'aras�nda');
  // cxSFilterOperatorNotBetween = 'not between';
  cxSetResourceString(@cxSFilterOperatorNotBetween, 'aras�nda de�il');
  // cxSFilterOperatorInList = 'in';
  cxSetResourceString(@cxSFilterOperatorInList, 'i�inde olan');
  // cxSFilterOperatorNotInList = 'not in';
  cxSetResourceString(@cxSFilterOperatorNotInList, 'i�inde olmayan');
  // cxSFilterOperatorYesterday = 'is yesterday';
  cxSetResourceString(@cxSFilterOperatorYesterday, 'd�n');
  // cxSFilterOperatorToday = 'is today';
  cxSetResourceString(@cxSFilterOperatorToday, 'bug�n');
  // cxSFilterOperatorTomorrow = 'is tomorrow';
  cxSetResourceString(@cxSFilterOperatorTomorrow, 'yar�n');
  // cxSFilterOperatorLastWeek = 'is last week';
  cxSetResourceString(@cxSFilterOperatorLastWeek, 'ge�en hafta');
  // cxSFilterOperatorLastMonth = 'is last month';
  cxSetResourceString(@cxSFilterOperatorLastMonth, 'ge�en ay');
  // cxSFilterOperatorLastYear = 'is last year';
  cxSetResourceString(@cxSFilterOperatorLastYear, 'ge�en sene');
  // cxSFilterOperatorThisWeek = 'is this week';
  cxSetResourceString(@cxSFilterOperatorThisWeek, 'bu hafta');
  // cxSFilterOperatorThisMonth = 'is this month';
  cxSetResourceString(@cxSFilterOperatorThisMonth, 'bu ay');
  // cxSFilterOperatorThisYear = 'is this year';
  cxSetResourceString(@cxSFilterOperatorThisYear, 'bu sene');
  // cxSFilterOperatorNextWeek = 'is next week';
  cxSetResourceString(@cxSFilterOperatorNextWeek, 'gelecek hafta');
  // cxSFilterOperatorNextMonth = 'is next month';
  cxSetResourceString(@cxSFilterOperatorNextMonth, 'gelecek ay');
  // cxSFilterOperatorNextYear = 'is next year';
  cxSetResourceString(@cxSFilterOperatorNextYear, 'gelecek sene');
  // cxSFilterAndCaption = 'and';
  cxSetResourceString(@cxSFilterAndCaption, 've');
  // cxSFilterOrCaption = 'or';
  cxSetResourceString(@cxSFilterOrCaption, 'veya');
  // cxSFilterNotCaption = 'not';
  cxSetResourceString(@cxSFilterNotCaption, 'de�il');
  // cxSFilterBlankCaption = 'blank';
  cxSetResourceString(@cxSFilterBlankCaption, 'bo�');
  // // derived
  // cxSFilterOperatorIsNull = 'is blank';
  cxSetResourceString(@cxSFilterOperatorIsNull, 'bo�luk');
  // cxSFilterOperatorIsNotNull = 'is not blank';
  cxSetResourceString(@cxSFilterOperatorIsNotNull, 'bo�luk de�il');
  // cxSFilterOperatorBeginsWith = 'begins with';
  cxSetResourceString(@cxSFilterOperatorBeginsWith, 'ile ba�layan');
  // cxSFilterOperatorDoesNotBeginWith = 'does not begin with';
  cxSetResourceString(@cxSFilterOperatorDoesNotBeginWith, 'ile ba�lamayan');
  // cxSFilterOperatorEndsWith = 'ends with';
  cxSetResourceString(@cxSFilterOperatorEndsWith, 'ile biten');
  // cxSFilterOperatorDoesNotEndWith = 'does not end with';
  cxSetResourceString(@cxSFilterOperatorDoesNotEndWith, 'ile bitmeyen');
  // cxSFilterOperatorContains = 'contains';
  cxSetResourceString(@cxSFilterOperatorContains, 'i�eren');
  // cxSFilterOperatorDoesNotContain = 'does not contain';
  cxSetResourceString(@cxSFilterOperatorDoesNotContain, 'i�ermeyen');
  // // filter listbox's values
  // cxSFilterBoxAllCaption = '(All)';
  cxSetResourceString(@cxSFilterBoxAllCaption, 'Hepsi');
  // cxSFilterBoxCustomCaption = '(Custom...)';
  cxSetResourceString(@cxSFilterBoxCustomCaption, '�zel...');
  // cxSFilterBoxBlanksCaption = '(Blanks)';
  cxSetResourceString(@cxSFilterBoxBlanksCaption, '(Bo� olanlar)');
  // cxSFilterBoxNonBlanksCaption = '(NonBlanks)';
  cxSetResourceString(@cxSFilterBoxNonBlanksCaption, '(Bo� olmayanlar)');

  { ******************************************************************** }
  { cxFilterControlStrs }
  { ******************************************************************** }

  // // cxFilterBoolOperator
  // cxSFilterBoolOperatorAnd = 'AND';        // all
  cxSetResourceString(@cxSFilterBoolOperatorAnd, 'VE');
  // cxSFilterBoolOperatorOr = 'OR';          // any
  cxSetResourceString(@cxSFilterBoolOperatorOr, 'VEYA');
  // cxSFilterBoolOperatorNotAnd = 'NOT AND'; // not all
  cxSetResourceString(@cxSFilterBoolOperatorNotAnd, 'VE DE��L');
  // cxSFilterBoolOperatorNotOr = 'NOT OR';   // not any
  cxSetResourceString(@cxSFilterBoolOperatorNotOr, 'VEYA DE��L');
  // //
  // cxSFilterRootButtonCaption = 'Filter';
  cxSetResourceString(@cxSFilterRootButtonCaption, 'Filtre');
  // cxSFilterAddCondition = 'Add &Condition';
  cxSetResourceString(@cxSFilterAddCondition, '&Ko�ul ekle');
  // cxSFilterAddGroup = 'Add &Group';
  cxSetResourceString(@cxSFilterAddGroup, '&Grup ekle');
  // cxSFilterRemoveRow = '&Remove Row';
  cxSetResourceString(@cxSFilterRemoveRow, '&Sat�r kald�r');
  // cxSFilterClearAll = 'Clear &All';
  cxSetResourceString(@cxSFilterClearAll, 'Hepsini &temizle');
  // cxSFilterFooterAddCondition = 'press the button to add a new condition';
  cxSetResourceString(@cxSFilterFooterAddCondition,
    'yeni ko�ul eklemek i�in tu�a bas�n');
  // cxSFilterGroupCaption = 'applies to the following conditions';
  cxSetResourceString(@cxSFilterGroupCaption, 'a�a��daki ko�ullar� uygulay�n');
  // cxSFilterRootGroupCaption = '<root>';
  cxSetResourceString(@cxSFilterRootGroupCaption, '<k�k>');
  // cxSFilterControlNullString = '<empty>';
  cxSetResourceString(@cxSFilterControlNullString, '<bo�>');
  // cxSFilterErrorBuilding = 'Can''t build filter from source';
  cxSetResourceString(@cxSFilterErrorBuilding, 'Kaynaktan filtrelenemiyor');
  // //FilterDialog
  // cxSFilterDialogCaption = 'Custom Filter';
  cxSetResourceString(@cxSFilterDialogCaption, '�zel filtre');
  // cxSFilterDialogInvalidValue = 'Invalid value';
  cxSetResourceString(@cxSFilterDialogInvalidValue, 'Ge�ersiz de�er');
  // cxSFilterDialogUse = 'Use';
  cxSetResourceString(@cxSFilterDialogUse, 'Kullan');
  // cxSFilterDialogSingleCharacter = 'to represent any single character';
  cxSetResourceString(@cxSFilterDialogSingleCharacter,
    'tek karakteri temsil etmek i�in');
  // cxSFilterDialogCharactersSeries = 'to represent any series of characters';
  cxSetResourceString(@cxSFilterDialogCharactersSeries,
    'pe� pe�e karakterleri temsil etmek i�in');
  // cxSFilterDialogOperationAnd = 'AND';
  cxSetResourceString(@cxSFilterDialogOperationAnd, 'VE');
  // cxSFilterDialogOperationOr = 'OR';
  cxSetResourceString(@cxSFilterDialogOperationOr, 'VEYA');
  // cxSFilterDialogRows = 'Show rows where:';
  cxSetResourceString(@cxSFilterDialogRows, 'Sat�rlar� goster');
  //
  // // FilterControlDialog
  // cxSFilterControlDialogCaption = 'Filter builder';
  cxSetResourceString(@cxSFilterControlDialogCaption, 'Filtre haz�rlay�c�');
  // cxSFilterControlDialogNewFile = 'untitled.flt';
  cxSetResourceString(@cxSFilterControlDialogNewFile, 'isimsiz.flt');
  // cxSFilterControlDialogOpenDialogCaption = 'Open an existing filter';
  cxSetResourceString(@cxSFilterControlDialogOpenDialogCaption, 'Filtre a�');
  // cxSFilterControlDialogSaveDialogCaption = 'Save the active filter to file';
  cxSetResourceString(@cxSFilterControlDialogSaveDialogCaption,
    'Ge�erli filtreyi kaydet');
  // cxSFilterControlDialogActionSaveCaption = '&Save As...';
  cxSetResourceString(@cxSFilterControlDialogActionSaveCaption,
    '&Farkl� kaydet');
  // cxSFilterControlDialogActionOpenCaption = '&Open...';
  cxSetResourceString(@cxSFilterControlDialogActionOpenCaption, '&A�...');
  // cxSFilterControlDialogActionApplyCaption = '&Apply';
  cxSetResourceString(@cxSFilterControlDialogActionApplyCaption, '&Uygula');
  // cxSFilterControlDialogActionOkCaption = 'OK';
  cxSetResourceString(@cxSFilterControlDialogActionOkCaption, 'Tamam');
  // cxSFilterControlDialogActionCancelCaption = 'Cancel';
  cxSetResourceString(@cxSFilterControlDialogActionCancelCaption, '�ptal');
  // cxSFilterControlDialogFileExt = 'flt';
  // cxSFilterControlDialogFileFilter = 'Filters (*.flt)|*.flt';
  cxSetResourceString(@cxSFilterControlDialogFileFilter,
    'Filtreler (*.flt)|*.flt');

  // cxGridPopupMenuConsts
  cxSetResourceString(@cxSGridNone, 'Yok'); // 'None';
  cxSetResourceString(@cxSGridSortColumnAsc, 'Artan S�ralama');
  // 'Sort Ascending';
  cxSetResourceString(@cxSGridSortColumnDesc, 'Azalan S�ralama');
  // 'Sort Descending';
  cxSetResourceString(@cxSGridClearSorting, 'S�ralamay� Sil');
  // 'Clear Sorting';
  cxSetResourceString(@cxSGridGroupByThisField, 'Bu Alana G�re Grupla');
  // 'Group By This Field';
  cxSetResourceString(@cxSGridRemoveThisGroupItem, 'Gruplamay� Sil');
  // 'Remove from grouping';
  cxSetResourceString(@cxSGridGroupByBox, 'Gruplama Kutusu'); // 'Group By Box';
  cxSetResourceString(@cxSGridAlignmentSubMenu, 'Hizalama'); // 'Alignment';
  cxSetResourceString(@cxSGridAlignLeft, 'Sola Hizala'); // 'Align Left';
  cxSetResourceString(@cxSGridAlignRight, 'Sa�a Hizala'); // 'Align Right';
  cxSetResourceString(@cxSGridAlignCenter, 'Ortal� Hizala'); // 'Align Center';
  cxSetResourceString(@cxSGridRemoveColumn, 'Sutunu Sil');
  // 'Remove This Column';
  cxSetResourceString(@cxSGridFieldChooser, 'Alan Se�i�i'); // 'Field Chooser';
  cxSetResourceString(@cxSGridBestFit, 'En Uygun B�y�kl�k'); // 'Best Fit';
  cxSetResourceString(@cxSGridBestFitAllColumns,
    'En Uygun B�y�kl�k(B�t�n Sutunlar)'); // 'Best Fit (all columns)';
  cxSetResourceString(@cxSGridShowFooter, 'Alt'); // 'Footer';
  cxSetResourceString(@cxSGridShowGroupFooter, 'Grup Alt'); // 'Group Footers';
  cxSetResourceString(@cxSGridSumMenuItem, 'Toplam'); // 'Sum';
  cxSetResourceString(@cxSGridMinMenuItem, 'Minimum'); // 'Min';
  cxSetResourceString(@cxSGridMaxMenuItem, 'Maximum'); // 'Max';
  cxSetResourceString(@cxSGridCountMenuItem, 'Adet'); // 'Count';
  cxSetResourceString(@cxSGridAvgMenuItem, 'Avaraj'); // 'Average';
  cxSetResourceString(@cxSGridNoneMenuItem, 'Yok'); // 'None';
end;

end.
