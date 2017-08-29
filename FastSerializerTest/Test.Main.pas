unit Test.Main;

interface

uses
  DJSON,
  XSuperObject,
  System.Diagnostics,
  DUnitX.TestFramework;

type
  TAdress = class
    adress: string;
    city: string;
    pc: Integer;
  end;

  TModel = class(TObject)
    Name: string;
    vip: Boolean;
    telephones: TArray<string>;
    age: Integer;
    size: Single;
    adresses: TArray<TAdress>;
  end;

  [TestFixture]
  TMyTestObject = class(TObject)
  public
    // Sample Methods
    // Simple single Test
    [Test]
    procedure TestXSuperObject;
    [Test]
    procedure TestDJSON;
  end;

implementation

uses
  DJSON.Params;

const
  XJSON = '{' + #13#10 +                                                    //
    '"name": "Onur YILDIZ",' + #13#10 +                               //
    '"vip": true,' + #13#10 +                                         //
    '"telephones": ["000000000", "111111111111"],' + #13#10 +         //
    '"age": 24,' + #13#10 +                                           //
    '"size": 1.72,' + #13#10 +                                        //
    '"adresses": [' + #13#10 +                                        //
    '{' + #13#10 +                                                  //
    '"adress": "blabla",' + #13#10 +                              //
    '"city": "Antalya",' + #13#10 +                               //
    '"pc": 7160' + #13#10 +                                       //
    '},' + #13#10 +                                                 //
    '{' + #13#10 +                                                  //
    '"adress": "blabla",' + #13#10 +                              //
    '"city": "Adana",' + #13#10 +                                 //
    '"pc": 1170' + #13#10 +                                       //
    '}' + #13#10 +                                                  //
    ']' + #13#10 +                                                     //
    '}'                                                                  //
;

procedure TMyTestObject.TestDJSON;
var
  LModel: TModel;
  I: Integer;
  LDest: IdjParams;
begin
  LDest := dj.Default;
  LDest.Engine := TdjEngine.eJDO;
  for I := 0 to 1000 do
  begin
    LModel := dj.FromJson(XJSON, LDest).&To < TModel > ;
  end;
end;

procedure TMyTestObject.TestXSuperObject;
var
  LModel: TModel;
  XO: TSuperObject;
  I: Integer;
begin
  for I := 0 to 1000 do
  begin
    XO := TSuperObject.Create(XJSON);
    LModel := XO.AsType<TModel>;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TMyTestObject);

end.

