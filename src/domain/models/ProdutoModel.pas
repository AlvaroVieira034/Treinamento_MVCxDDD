unit ProdutoModel;

interface

uses System.SysUtils, FireDAC.Comp.Client, FireDAC.DApt;

type
  EProdutoException = class(Exception);
  TProduto = class

  private
    FCod_Produto: Integer;
    FDes_Descricao: string;
    FDes_Marca: string;
    FVal_Preco: Double;

    // Métodos de validação
    procedure ValidarDescricao;
    procedure ValidarMarca;
    procedure ValidarPrecoUnitario;
    procedure SetDes_Descricao(const Value: string);
    procedure SetDes_Marca(const Value: string);
    procedure SetVal_Preco(const Value: Double);

  public
    constructor Create;
    destructor Destroy; override;

    // Comportamentos
    procedure Validar;
    function ObterErrosValidacao: TArray<string>;

    // Properties
    property Cod_Produto: Integer read FCod_Produto write FCod_Produto;
    property Des_Descricao: string read FDes_Descricao write FDes_Descricao;
    property Des_Marca: string read FDes_Marca write FDes_Marca;
    property Val_Preco: Double read FVal_Preco write FVal_Preco;

  end;

implementation

{ TProduto }

constructor TProduto.Create;
begin

end;

destructor TProduto.Destroy;
begin

  inherited;
end;

procedure TProduto.SetDes_Descricao(const Value: string);
begin

end;

procedure TProduto.SetDes_Marca(const Value: string);
begin

end;

procedure TProduto.SetVal_Preco(const Value: Double);
begin

end;

procedure TProduto.Validar;
begin

end;

procedure TProduto.ValidarDescricao;
begin

end;

procedure TProduto.ValidarMarca;
begin

end;

procedure TProduto.ValidarPrecoUnitario;
begin

end;

function TProduto.ObterErrosValidacao: TArray<string>;
begin

end;

end.
